<#
.SYNOPSIS
Activates a conda virtualenv.

.DESCRIPTION
Activate.ps1 and deactivate.ps1 recreates the existing virtualenv BAT files in PS1 format so they "just work" inside a Powershell session.  
This isn't idiomatic Powershell, just a translation.
#>

Param(
    [string]$global:condaEnvName
)

# fix for pre-PS3 - creates $PSScriptRoot
if (-not $PSScriptRoot)
{ 
    $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent 
}

# Get location of Anaconda installation
$condaInstallPath = (get-item $PSScriptRoot).parent.FullName

# Build ENVS path
$env:CONDA_ENVS = $condaInstallPath + '\envs'

if ( [string]::IsNullOrEmpty($condaEnvName) ) {
    $condaEnvName = "base"
}

if ($condaEnvName -eq "base") {
	$Env:CONDA_PREFIX = $condaInstallPath
} else {
	$Env:CONDA_PREFIX = "$env:CONDA_ENVS\$condaEnvName"
}

##
if (-not $Env:CONDA_PREFIX)
{
    Write-Host
    Write-Host "Usage: activate [base | envname] [-UpdateRegistry]"
    Write-Host
    Write-Host "Deactivates previously activated Conda environment, then activates the chosen one."
    Write-Host
    Write-Host
    exit
}

# Test the path to python.exe
if (-not (Test-Path "$env:CONDA_PREFIX\Python.exe"))
{
    Write-Host
    Write-Warning "No environment named `"$condaEnvName`" exists in $env:CONDA_ENVS."
    Write-Host
    Write-Host
    exit 
}

# Deactivate a previous activation if it is live
if (Test-Path env:\CONDA_DEFAULT_ENV) {
    Invoke-Expression deactivate.ps1
}

## setup
$env:CONDA_DEFAULT_ENV = $condaEnvName
$Env:CONDA_EXE = "$Env:CONDA_PREFIX\Scripts\conda.exe"
$Env:CONDA_PYTHON_EXE = "$Env:CONDA_PREFIX\python.exe"

Write-Host
Write-Host "Activating environment `"$env:CONDA_DEFAULT_ENV...`""
$env:CONDA_SAVED_PATH = $Env:Path
$Env:Path="$Env:CONDA_PREFIX;$Env:CONDA_PREFIX\Scripts;$Env:CONDA_PREFIX\Library\bin;$Env:CONDA_SAVED_PATH"
Write-Host
Write-Host

# Capture existing user prompt
function global:condaUserPrompt {''}
$function:condaUserPrompt = $function:prompt

function global:prompt
{
    # Add the virtualenv prefix to the current user prompt.
    Write-Host "[$condaEnvName] " -nonewline -ForegroundColor Red
    & $function:condaUserPrompt
}
