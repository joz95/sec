' the script expects arguments like:
' first param (zipfile): c:\Users\Public\zipfile.zip
' second param (dir to unzip): c:\Users\Public\dir2extract\
'
' c:\unzipfile <zipfile> <dir_to_unzip>
'
' Ex:
' c:\unzipfile  c:\Users\Public\zipfile.zip c:\Users\Public\dir2extract\


Dim arg, ZipFile, ExtractTo
Set arg = WScript.Arguments

ZipFile=arg(0)
ExtractTo=arg(1)

'If the extraction location does not exist create it.

Set fso = CreateObject("Scripting.FileSystemObject")

If NOT fso.FolderExists(ExtractTo) Then
 fso.CreateFolder(ExtractTo)
End If

'Extract the contants of the zip file.

set objShell = CreateObject("Shell.Application")
set FilesInZip=objShell.NameSpace(ZipFile).items

objShell.NameSpace(ExtractTo).CopyHere(FilesInZip)

Set fso = Nothing
Set objShell = Nothing
Set arg = Nothing

