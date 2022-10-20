# Greeting
cls

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


# PNPM
Set-Alias -Name pn -Value pnpm

function pa {
	pnpm add $args
}

function pr {
  pnpm remove $args
}

function pu {
  pnpm update
}

function pasd {
  pnpm add --save-dev $args
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

function touch {
  ni $args
}

function rm {
  Remove-Item -Recurse -Force $args
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
