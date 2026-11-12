"""Ponto de entrada do Meu Diário de Atividades.

Execute com:  python main.py
"""
from __future__ import annotations

import logging
import sys
import tkinter
from tkinter import messagebox

from app import APP_NAME
from app.config import AppPaths, default_data_dir
from app.database import DatabaseTooNewError
from app.logging_setup import setup_logging
from app.single_instance import SingleInstance, bring_existing_window_to_front


def _set_app_id() -> None:
    """Identidade própria na barra de tarefas do Windows: mostra a logomarca do programa
    (e não o ícone do Python) também quando executado pelo VS Code.

    No executável não é necessário (o Windows já usa o ícone do .exe) e mudaria o
    agrupamento com um atalho que o usuário tenha fixado na barra de tarefas."""
    if sys.platform != "win32" or getattr(sys, "frozen", False):
        return
    try:
        import ctypes

        ctypes.windll.shell32.SetCurrentProcessExplicitAppUserModelID("MeuDiarioDeAtividades.App")
    except (AttributeError, OSError):
        pass


def _show_startup_error(message: str) -> None:
    root = tkinter.Tk()
    root.withdraw()
    messagebox.showerror(APP_NAME, message)
    root.destroy()


def main() -> int:
    if "--autoteste" in sys.argv:
        # Validação do executável (não usa os dados reais). Resultado opcional em arquivo.
        from pathlib import Path

        from app.selftest import run_self_test

        index = sys.argv.index("--autoteste")
        result = Path(sys.argv[index + 1]) if len(sys.argv) > index + 1 else None
        return run_self_test(result)

    paths = AppPaths(default_data_dir())
    try:
        paths.ensure()
    except OSError as exc:
        _show_startup_error(f"Não foi possível criar a pasta de dados:\n{paths.data_dir}\n\nDetalhe: {exc}")
        return 1
    setup_logging(paths.log_dir)
    logger = logging.getLogger("main")

    guard = SingleInstance(paths.data_dir)
    if not guard.acquire():
        if not bring_existing_window_to_front(APP_NAME):
            _show_startup_error("O Meu Diário de Atividades já está aberto.")
        return 0

    # Importações mais pesadas só depois das verificações rápidas.
    from app.services import AppServices
    from app.ui.main_window import MainWindow

    try:
        services = AppServices.create(paths)
    except DatabaseTooNewError:
        _show_startup_error(
            "Os seus dados foram gravados por uma versão mais nova do programa.\n\n"
            "Instale a versão mais recente do Meu Diário de Atividades para continuar."
        )
        return 1
    except Exception as exc:  # noqa: BLE001
        logger.exception("Falha ao abrir o banco de dados")
        _show_startup_error(
            "Não foi possível abrir o banco de dados.\n\n"
            f"Pasta de dados: {paths.data_dir}\n\nDetalhe: {exc}\n\n"
            "Se o problema continuar, restaure um backup da pasta 'backups'."
        )
        return 1

    logger.info("Aplicação iniciada")
    _set_app_id()
    try:
        app = MainWindow(services)
        app.mainloop()
    finally:
        services.close()
        guard.release()
        logger.info("Aplicação encerrada")
    return 0


if __name__ == "__main__":
    sys.exit(main())
