<#
.SYNOPSIS
    Gera o executável do Meu Diário de Atividades (Windows) com o PyInstaller.

.DESCRIPTION
    1. Cria o ambiente virtual .venv (se ainda não existir) e instala as dependências;
    2. Executa os testes automatizados (use -PularTestes para não executar);
    3. Gera o executável em dist\MeuDiarioDeAtividades;
    4. Roda o autoteste do executável gerado.

    O computador de destino NÃO precisa ter Python instalado.

.PARAMETER UmArquivo
    Gera um único arquivo .exe (mais fácil de copiar, porém abre mais devagar).
    Sem este parâmetro, gera uma pasta com o .exe (abre mais rápido — recomendado).

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\build_exe.ps1
    powershell -ExecutionPolicy Bypass -File .\build_exe.ps1 -UmArquivo
#>
param(
    [switch]$UmArquivo,
    [switch]$PularTestes
)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
$AppName = "MeuDiarioDeAtividades"
$Python = Join-Path $PSScriptRoot ".venv\Scripts\python.exe"

if (-not (Test-Path $Python)) {
    Write-Host "==> Criando ambiente virtual (.venv)..." -ForegroundColor Cyan
    python -m venv .venv
    if ($LASTEXITCODE -ne 0) { throw "Não foi possível criar o ambiente virtual. O Python está instalado?" }
}

Write-Host "==> Instalando dependências..." -ForegroundColor Cyan
& $Python -m pip install --quiet --upgrade pip
& $Python -m pip install --quiet -r requirements-dev.txt
if ($LASTEXITCODE -ne 0) { throw "Falha ao instalar as dependências." }

if (-not $PularTestes) {
    Write-Host "==> Executando os testes automatizados..." -ForegroundColor Cyan
    & $Python -m pytest -q -p no:cacheprovider
    if ($LASTEXITCODE -ne 0) { throw "Os testes falharam. Corrija antes de gerar o executável." }
}

Write-Host "==> Gerando o executável..." -ForegroundColor Cyan
$Mode = if ($UmArquivo) { "--onefile" } else { "--onedir" }
$Icon = Join-Path $PSScriptRoot "assets\icone.ico"
$Assets = Join-Path $PSScriptRoot "assets"
& $Python -m PyInstaller `
    --noconfirm --clean --windowed $Mode `
    --name $AppName `
    --icon $Icon `
    --add-data "$Assets;assets" `
    --collect-data customtkinter `
    --specpath build `
    --distpath dist `
    --workpath build `
    main.py
if ($LASTEXITCODE -ne 0) { throw "O PyInstaller não conseguiu gerar o executável." }

$Exe = if ($UmArquivo) { Join-Path $PSScriptRoot "dist\$AppName.exe" } else { Join-Path $PSScriptRoot "dist\$AppName\$AppName.exe" }

Write-Host "==> Testando o executável gerado (autoteste)..." -ForegroundColor Cyan
$Result = Join-Path $env:TEMP "meudiario_autoteste.txt"
$Process = Start-Process -FilePath $Exe -ArgumentList "--autoteste", "`"$Result`"" -Wait -PassThru
if (Test-Path $Result) { Get-Content $Result -Encoding UTF8 | ForEach-Object { Write-Host "    $_" } }
if ($Process.ExitCode -ne 0) { throw "O autoteste do executável falhou." }

Write-Host ""
Write-Host "Executável pronto:" -ForegroundColor Green
Write-Host "    $Exe"
if (-not $UmArquivo) {
    Write-Host "Copie a pasta inteira dist\$AppName para o computador de destino e crie um atalho para o .exe."
}
