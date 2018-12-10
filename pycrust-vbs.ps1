
# Activate the CONDA envrionment
D:\utils\anaconda3\Scripts\activate.ps1 base

$WshShell = New-Object -comObject WScript.Shell
$WshShell.Run("D:\utils\anaconda3\Scripts\pycrust.exe", 0, $false)
