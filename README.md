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

### �������⼰����취

�� PowerShell ��ִ�� activate.ps1 ���ܻ�������´���

```
PS D:\baseno\datumoj\SPLN-res> D:\utils\anaconda3\Scripts\activate.ps1
D:\utils\anaconda3\Scripts\activate.ps1 : �޷������ļ� D:\utils\anaconda3\Scripts\activate.ps1����Ϊ�ڴ�ϵͳ�Ͻ�ֹ����
�ű����й���ϸ��Ϣ������� https:/go.microsoft.com/fwlink/?LinkID=135170 �е� about_Execution_Policies��
����λ�� ��:1 �ַ�: 1
+ D:\utils\anaconda3\Scripts\activate.ps1
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) []��PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess
```

����������ԭ����ϵͳ�Ľű��������ò���Ϊ����ֹ���С���ǩ���ű����� `Get-ExecutionPolicy` �鿴���䷵�صĽ��Ӧ���� `Restricted`.

����취��
1. �ù���ԱȨ�޴� PowerShell
2. ִ�� `Set-ExecutionPolicy RemoteSigned`, ����ʾ������ѡ�� Y �� A��ȫ�ǣ���
