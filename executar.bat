@echo off
rem Inicia o Meu Diario de Atividades usando o ambiente virtual do projeto.
cd /d "%~dp0"
if not exist ".venv\Scripts\pythonw.exe" (
    echo Ambiente virtual nao encontrado. Veja o README.md, secao "Como executar".
    pause
    exit /b 1
)
start "" ".venv\Scripts\pythonw.exe" main.py
