PSCondaEnvs
===========

Drop in replacement scripts that replicate Conda's activate/deactivate functions in Powershell.


###Installation:
Simply copy activate.ps1 and deactivate.ps1 into your Anaconda\Scripts directory.  You may need to remove or rename the existing BAT files but the PS1 versions seem to get precedence.

###Added Features:
The optional -UpdateRegistry switch has been added which will update the Python installpath to be the activated virtualenv.  I added this for installing compiled modules which detect the Python path from the registry.
THIS SHOULD BE USED WITH EXTREME CAUTION!  This has only been tested on my system and is hardcoded to the 2.7 installpath.  This setting is also persistent unlike the session-based ephemeral virtualenv activation.  Deactivate.ps1 will detect and prompt for reverting the change if a virtualenv hasn't been properly deactivated.

###Credit:
* Original Conda batch files.
* https://bitbucket.org/guillermooo/virtualenvwrapper-powershell

### 运行问题及解决办法

在 PowerShell 中执行 activate.ps1 可能会出现如下错误：

```
PS D:\baseno\datumoj\SPLN-res> D:\utils\anaconda3\Scripts\activate.ps1
D:\utils\anaconda3\Scripts\activate.ps1 : 无法加载文件 D:\utils\anaconda3\Scripts\activate.ps1，因为在此系统上禁止运行
脚本。有关详细信息，请参阅 https:/go.microsoft.com/fwlink/?LinkID=135170 中的 about_Execution_Policies。
所在位置 行:1 字符: 1
+ D:\utils\anaconda3\Scripts\activate.ps1
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) []，PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess
```

引起该问题的原因是系统的脚本环境设置策略为“禁止运行”非签名脚本。用 `Get-ExecutionPolicy` 查看，其返回的结果应该是 `Restricted`.

解决办法：
1. 用管理员权限打开 PowerShell
2. 执行 `Set-ExecutionPolicy RemoteSigned`, 对提示的问题选择 Y 或 A（全是）。
