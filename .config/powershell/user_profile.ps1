# Greeting
Clear-Host

If (-Not (Test-Path Variable:PSise)) {  # Only run this in the console and not in the ISE
    Import-Module Get-ChildItemColor
    
    Set-Alias l Get-ChildItemColor -option AllScope
    Set-Alias ll Get-ChildItemColorFormatWide -option AllScope 
}

# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Import-Module posh-git
$omp_config = Join-Path $PSScriptRoot ".\takuya.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

Import-Module -Name Terminal-Icons

# Alias
Set-Alias -Name vi -Value nvim
Set-Alias g git
Set-Alias cl clear
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

function x {
    exit
}

# PNPM
Set-Alias -Name pn -Value pnpm

function .. {
  Set-Location ..
}

function pa($arg) {
  foreach ($i in $arg) {
     pnpm add --save-dev $i
  }
}

function pr {
  pnpm remove $args
}

function pu {
  pnpm update
}

function pasd($arg) {
  foreach ($i in $arg) {
     pnpm add --save-dev $i
  }
}

function pl {
  pnpm list
}

function pin {
  pnpm init
}

function px {
  pnpm dlx
}

function pi {
  pnpm install
}

# GITHUB
. $PSScriptRoot\aliases.ps1

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# PSReadLine
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

Invoke-Expression (&starship init powershell)
