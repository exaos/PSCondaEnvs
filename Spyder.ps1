
# Hide PowerShell Console
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)

# Activate the CONDA envrionment
D:\utils\anaconda3\Scripts\activate.ps1 base

# Run the utility.
# Invoke-Expression "$Env:CONDA_PREFIX\Scripts\jupyter-qtconsole.exe"
# & "$Env:CONDA_PREFIX\Scripts\jupyter-qtconsole.exe"
pythonw.exe "$Env:CONDA_PREFIX\Scripts\spyder-script.py"
