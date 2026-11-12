# Meu Diário de Atividades

Diário profissional para registrar, em poucos segundos, as atividades realizadas no dia,
acompanhar a evolução das demandas e gerar relatórios em PDF e Excel para a gestão.

Funciona **100% offline**, no próprio computador, sem login e sem servidor.

---

## Sumário

1. [O que o sistema faz](#o-que-o-sistema-faz)
2. [Como executar no VS Code](#como-executar-no-vs-code)
3. [Como usar](#como-usar)
4. [Onde ficam os dados e como funciona o backup](#onde-ficam-os-dados-e-como-funciona-o-backup)
5. [Identidade visual](#identidade-visual)
6. [Gerar o executável (.exe)](#gerar-o-executável-exe)
7. [Testes automatizados](#testes-automatizados)
8. [Estrutura do projeto](#estrutura-do-projeto)
9. [Solução de problemas](#solução-de-problemas)

---

## O que o sistema faz

| Tela | Para que serve |
|---|---|
| **Painel de controle** (primeiro item do menu) | Cartões com o total de atividades registradas e de demandas em andamento, concluídas, aguardando terceiros e pausadas, para o período escolhido. Clique em um cartão para listar as demandas daquela situação; clique duplo abre a evolução da demanda. |
| **Registrar atividade** (tela inicial) | Data (já preenchida com hoje), área (com o link **+ Nova área** para incluir novos tipos), nome, descrição, situação, projeto e evidências. Salvar com um clique ou **Ctrl+S**. |
| **Histórico de atividades** | Lista todos os registros (mais recentes primeiro), com pesquisa e filtros por período, área, situação e projeto. Ver detalhes, editar, excluir, continuar uma demanda e ver a evolução de um projeto. |
| **Relatórios** | Semana atual/anterior, mês atual/anterior, trimestre, semestre, ano atual/anterior, todo o histórico ou período personalizado; filtros por projeto e área. Visualizar na tela, exportar PDF ou Excel. |
| **Configurações e backup** (discreto, no rodapé do menu) | Seu nome/cargo/setor para os relatórios, áreas de atuação, backup e restauração, e registros excluídos. |

Destaques:

- **Continuidade de demandas:** vários registros (cada um com sua data e descrição) podem ser vinculados ao
  mesmo projeto. O nome do projeto é reconhecido mesmo com diferenças de maiúsculas, acentos ou espaços
  ("Leitor de DARFs" = "leitor de darfs"), evitando projetos duplicados.
- **Nada se perde:** o que está sendo digitado é guardado automaticamente como rascunho e recuperado se o
  programa for fechado; a edição de um registro guarda a versão anterior; excluir envia para
  "Registros excluídos", de onde é possível restaurar.
- **Relatórios fiéis:** usam somente o que foi registrado — nenhum texto é inventado.

---

## Como executar no VS Code

Pré-requisito: **Python 3.12 ou mais recente** instalado (marque "Add python.exe to PATH" na instalação).

1. Abra a pasta do projeto no VS Code (*Arquivo > Abrir Pasta…*).
2. Abra o terminal (*Terminal > Novo Terminal*) e crie o ambiente virtual com as dependências:

   ```powershell
   python -m venv .venv
   .\.venv\Scripts\python.exe -m pip install -r requirements-dev.txt
   ```

3. Inicie o aplicativo:

   ```powershell
   .\.venv\Scripts\python.exe main.py
   ```

   Ou pressione **F5** e escolha **"Executar Meu Diário de Atividades"** (configuração já incluída em
   `.vscode/launch.json`). Também é possível dar dois cliques em **`executar.bat`**.

> **Para experimentar sem misturar com seus dados reais**, use a configuração
> **"Executar com dados de teste (pasta separada)"** do F5. Ela grava tudo em `.dados_teste/`, dentro do projeto.

---

## Como usar

### Registro diário (fluxo principal)

**Abrir o sistema → digitar o nome da atividade → descrever o trabalho → Salvar.**

- A data já vem com o dia de hoje. Para registros de dias anteriores, digite a data, use o botão
  **Calendário** ou as setas **↑/↓** no campo (avançam/voltam um dia).
- A área usada por último já vem selecionada. Para incluir um novo tipo de área, clique em **+ Nova área**
  (acima do campo *Área de atuação*), digite o nome e clique em *Adicionar*: a área é criada e já fica
  selecionada. Nomes repetidos não são duplicados ("Fiscal" = "fiscal"). Para renomear, ocultar ou excluir
  áreas, use *Configurações e backup > Áreas de atuação*.
- No campo **Projeto ou demanda vinculada**, escolha na lista (seta do campo ou tecla **↓**) ou digite um nome
  novo. A lista mostra os projetos e também as **demandas registradas sem projeto**: ao escolher uma delas, os
  registros anteriores dessa demanda são agrupados automaticamente no mesmo projeto. Abaixo do campo aparece o que
  vai acontecer ao salvar, e o aviso de sucesso confirma a qual projeto a atividade foi vinculada.
- **Evidências:** clique em *Anexar arquivos…*. Os arquivos são **copiados** para a pasta de dados do
  programa — continuam acessíveis mesmo que o original seja movido ou apagado, e entram nos backups.
- Após salvar, aparece **"Atividade registrada com sucesso!"**, os campos são limpos (mantendo a data de
  hoje) e o histórico é atualizado. Cliques repetidos em Salvar não criam registros duplicados.

### Continuar uma demanda em outro dia

No Histórico (ou nos detalhes de um registro, ou na evolução do projeto), clique em **Continuar demanda**. O
formulário de registro é aberto com a área, o nome e o projeto preenchidos e a data de hoje — basta descrever o
trabalho do dia. O conteúdo dos registros anteriores **não é alterado**. Se a demanda ainda não tinha projeto, o
nome dela é usado como projeto e os registros anteriores passam a fazer parte da mesma evolução.

### Ver tudo o que foi feito em um dia

Na tela de registro, clique no link do canto superior direito ("2 registros hoje — ver no histórico"), ou no
Histórico escolha o período **Hoje**, **Ontem** ou **Período personalizado**.

### Relatórios

Escolha o período (e, se quiser, um projeto ou área) e clique em **VISUALIZAR RELATÓRIO**, **EXPORTAR PDF** ou
**EXPORTAR EXCEL**. O PDF traz cabeçalho com responsável e período, indicadores, quantidade por área, todas as
atividades em ordem cronológica e um resumo (principais atividades, demandas concluídas, em andamento e
impedimentos). O Excel tem as abas *Resumo*, *Atividades* (com filtros e datas no formato de data) e *Demandas*.

> Informe seu nome em **Configurações e backup > Seus dados** para que ele apareça nos relatórios.

### Atalhos de teclado

| Atalho | Ação |
|---|---|
| **Tab / Shift+Tab** | Próximo / campo anterior (também dentro da descrição) |
| **Ctrl+S** | Salvar (registro ou edição) |
| **Ctrl+1 / Ctrl+2 / Ctrl+3 / Ctrl+4** | Registrar / Histórico / Relatórios / Painel de controle |
| **Enter ou Espaço** | Aciona o botão em foco |
| **↑ / ↓** | Em listas: troca a opção. No campo de data: muda o dia |
| **← / →** | Troca a situação da atividade |
| **Alt+↓ ou F4** | Abre a lista ou o calendário |
| **Enter** (no histórico) | Abre os detalhes do registro selecionado |
| **Delete** (no histórico) | Exclui o registro selecionado (com confirmação) |
| **Esc** | Volta (detalhes, evolução) ou cancela a edição |

---

## Onde ficam os dados e como funciona o backup

Todos os dados ficam em uma pasta do usuário, **separada do programa**:

```
%LOCALAPPDATA%\MeuDiarioDeAtividades\
├── diario.db        banco de dados (SQLite)
├── evidencias\      cópias dos arquivos anexados
├── backups\         backups automáticos e manuais (.zip)
└── logs\            registro técnico de eventos (para diagnóstico)
```

Por isso, atualizar ou reinstalar o programa **não apaga** o histórico. Quando uma versão futura precisar
alterar a estrutura do banco, ele é atualizado automaticamente — e uma cópia de segurança é feita antes.

**Backup:**

- **Automático:** uma vez por dia, em segundo plano (pode ser desligado em Configurações). Os últimos 30
  backups automáticos são mantidos (configurável).
- **Manual:** *Configurações e backup > Backup e restauração > FAZER BACKUP AGORA*.
- **Cópia em outra pasta ou pendrive:** botão *Salvar cópia em outra pasta…*.
- Cada backup é um único `.zip` com o banco de dados (cópia consistente feita pelo próprio SQLite, mesmo
  com o programa aberto), todas as evidências e um arquivo de informações.

**Restauração:** escolha um backup da lista (ou um arquivo `.zip`) e confirme. O backup é verificado antes, e
uma **cópia de segurança dos dados atuais é criada automaticamente** — se mudar de ideia, basta restaurar essa
cópia. Durante a restauração a janela fica bloqueada (para nada ser alterado no meio do processo); se o
computador desligar no meio, a restauração é desfeita automaticamente na próxima abertura.

---

## Identidade visual

O visual segue a **regra 60-30-10**, com todas as cores definidas em um único lugar
(`app/palette.py`) e usadas pela tela, pelo PDF, pelo Excel e pela logomarca:

| Proporção | Cor | Onde aparece |
|---|---|---|
| **60%** neutro | fundo `#F4F6FA` e superfícies brancas | fundo das telas, cartões, campos e tabelas |
| **30%** azul-marinho | `#14213D` e seus tons | menu lateral, títulos, botões secundários, cabeçalhos de tabela, opções selecionadas |
| **10%** laranja | `#FCA311` | somente o botão de ação principal de cada tela e o item ativo do menu |

As cores de situação (em andamento, concluída, pausada, aguardando terceiros) aparecem só em pequenos
indicadores. Todos os pares de texto e fundo atendem ao contraste mínimo de acessibilidade (WCAG AA).

**Interação:** os botões mudam de cor suavemente ao passar o mouse e dão um retorno visual ao clicar (também
com Enter/Espaço). Os cartões do painel mostram um ícone, contam até o número ao abrir, exibem uma barra com a
fatia das demandas daquela situação e se destacam ao passar o mouse. Nas tabelas, a linha sob o mouse fica
realçada. Os avisos entram deslizando. Os ícones usam a fonte de ícones do próprio Windows; se ela não existir,
os botões aparecem só com o texto.

**Logomarca:** um caderno (diário) com espiral e um selo laranja de "atividade concluída". Ela aparece no menu
lateral, na janela, na barra de tarefas e no ícone do executável. Arquivos em `assets/`:

- `icone.ico`: ícone do executável e das janelas (16 a 256 px, com desenho simplificado nos tamanhos pequenos);
- `logo.png`: marca usada no menu lateral;
- `logomarca.png`: versão em alta resolução (1024 px) para documentos e apresentações.

Para recriar esses arquivos (por exemplo, após mudar as cores em `app/palette.py`):
`.\.venv\Scripts\python.exe tools\gerar_icone.py`.

---

## Gerar o executável (.exe)

No terminal do VS Code, na pasta do projeto:

```powershell
powershell -ExecutionPolicy Bypass -File .\build_exe.ps1
```

O script instala as dependências, roda os testes, gera o executável com o PyInstaller e executa um
**autoteste** do `.exe` gerado. Resultado:

```
dist\MeuDiarioDeAtividades\MeuDiarioDeAtividades.exe
```

- Copie a **pasta inteira** `dist\MeuDiarioDeAtividades` para o computador de destino (por exemplo, para
  `C:\Programas\MeuDiarioDeAtividades`) e crie um atalho do `.exe` na área de trabalho.
- O computador de destino **não precisa ter Python instalado**.
- Para gerar um **arquivo único** `.exe` (mais fácil de copiar, porém abre um pouco mais devagar):
  `.\build_exe.ps1 -UmArquivo`. Para pular os testes: `-PularTestes`.
- Para conferir um executável já gerado: `MeuDiarioDeAtividades.exe --autoteste resultado.txt`
  (usa uma pasta temporária; não toca nos seus dados).

> Alguns antivírus desconfiam de executáveis gerados pelo PyInstaller. Se isso acontecer, adicione uma exceção
> para a pasta do programa.

> **Ícone antigo ainda aparecendo?** O Windows guarda os ícones em cache. Copie a pasta nova por cima da
> antiga, apague e recrie o atalho da área de trabalho; se ainda assim aparecer o ícone antigo, reinicie o
> computador (ou execute `ie4uinit.exe -show` no terminal).

---

## Testes automatizados

```powershell
.\.venv\Scripts\python.exe -m pytest
```

São 105 testes, cobrindo: cadastro, vários registros no mesmo dia, datas retroativas, edição (com versão
anterior guardada), exclusão e restauração, continuidade de demandas, filtros e pesquisa, reinicialização
sem perda de dados, geração de PDF e Excel, relatórios sem registros, backup e restauração (inclusive com
arquivos inválidos ou danificados), abertura de evidências, a identidade visual (paleta, logomarca, ícone,
botões, cartões animados) e a interface (a janela real é aberta e os fluxos são executados). Os testes usam pastas temporárias e **nunca tocam nos dados reais**.

---

## Estrutura do projeto

```
main.py                     ponto de entrada
app/
  config.py                 caminhos de dados e constantes (áreas iniciais etc.)
  models.py                 estruturas de dados e situações das atividades
  palette.py                paleta de cores única (regra 60-30-10)
  database/                 conexão SQLite, esquema/migrações e consultas (repositórios)
  services/                 regras de negócio
    activity_service.py     cadastro, edição, exclusão, histórico de alterações
    project_service.py      projetos/demandas e sua evolução
    evidence_service.py     armazenamento e abertura das evidências
    report_service.py       montagem dos relatórios (somente dados registrados)
    pdf_exporter.py         relatório em PDF (ReportLab)
    excel_exporter.py       relatório em Excel (OpenPyXL)
    backup_service.py       backup e restauração
  ui/                       interface (CustomTkinter)
    theme.py                cores por função, fontes, botões e cartões padronizados
    animation.py            transições suaves (cores, números)
    icons.py                ícones (fonte do Windows), logomarca e ícone das janelas
    main_window.py          janela, menu lateral e navegação
    activity_form.py        formulário de registro/edição
    pages/                  telas (registrar, histórico, detalhes, evolução, relatórios, painel, configurações)
    widgets/                componentes (campo de data, listas, tabela, avisos…)
tests/                      testes automatizados (pytest)
assets/                     icone.ico, logo.png e logomarca.png
build_exe.ps1               geração do executável
tools/gerar_icone.py        recria a logomarca e o ícone (opcional)
```

---

## Solução de problemas

| Situação | O que fazer |
|---|---|
| "O Meu Diário de Atividades já está aberto." | O programa só abre uma janela por vez; procure-a na barra de tarefas. |
| Erro ao exportar relatório | Se o arquivo de destino estiver aberto no Excel ou no leitor de PDF, feche-o e tente de novo. |
| Evidência "não encontrada" | O arquivo foi removido manualmente da pasta de dados; restaure um backup. |
| Aviso de problema no arquivo de dados ao abrir | Restaure o backup mais recente em *Configurações e backup*. |
| Outro erro inesperado | Os detalhes ficam em `%LOCALAPPDATA%\MeuDiarioDeAtividades\logs\app.log`. |
