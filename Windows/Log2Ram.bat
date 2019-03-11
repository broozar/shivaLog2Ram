@echo off

REM Log2Ram for ShiVa
REM 2019-03-07 Felix Caffier


:paths
set BatchDir=%~dp0
set ResFolder=%BatchDir%Log2RamFiles

set ExePath192=%BatchDir%ShiVa.exe
set ExePath20=%BatchDir%ShiVaEditor.exe

set LogFolder192=%BatchDir%Logs
set LogFolder20=%LOCALAPPDATA%\ShiVa\Editor\Log

set ImDiskLocation=C:\Windows\System32\imdisk.exe


:check_Permissions
echo Administrative permissions required. Detecting permissions...

net session >nul 2>&1
if %errorLevel% == 0 (
	echo Success: Administrative permissions confirmed.
	goto imdisk_check
) else (
	"%ResFolder%\messager.exe" "Auth required" "You need to run this script as administrator."
	exit /B 1
)


:imdisk_check
if not exist "%ImDiskLocation%" (
	echo Failure: ImDisk not detected.
	"%ResFolder%\messager.exe" 'ImDisk missing' 'Please install ImDisk before running this script.'
	echo ImDisk: Launching installer.
	"%ResFolder%\imdiskinst.exe"
	exit /B 2
) 
echo Success: ImDisk appears to be installed.


:version_switch
if exist "%BatchDir%Qt5Core.dll" (
	echo Success: ShiVa 2.0 detected ^(QT5 framework^).
	goto main20
)
if exist "%BatchDir%mfc71.dll" (
	echo Success: ShiVa 1.9.2 detected ^(MFC framework^).
	goto main192
)
REM else: could not detect
echo Failure: ShiVa executable not detected.
"%ResFolder%\messager.exe" "Unknown version" "Could not detect ShiVa version."
exit /B 3


:main192
if not exist "%ExePath192%" (
	"%ResFolder%\messager.exe" 'ShiVa.exe missing' 'Could not locate ShiVa - You need to run this script from the ShiVa 1.9.2 editor directory.'
) 
echo Success: ShiVa 1.9.2 exe detected.

REM clean folder and mount ramdisk
rmdir /s /q "%LogFolder192%"
mkdir "%LogFolder192%"
imdisk -a -s 64M -m "%LogFolder192%" -p "/FS:NTFS /Y"
"%ExePath192%"
exit /B


:main20
if not exist "%ExePath20%" (
	"%ResFolder%\messager.exe" 'ShiVaEditor.exe missing' 'Could not locate ShiVa - You need to run this script from the ShiVa 2.0 editor directory.'
) 
echo Success: ShiVa 2.0 exe detected.

REM clean folder and mount ramdisk
if exist "%LogFolder20%" (
	rmdir /s /q "%LogFolder20%"
)
md "%LogFolder20%"
imdisk -a -s 64M -m "%LogFolder20%" -p "/FS:NTFS /Y"
"%ExePath20%"
exit /B
