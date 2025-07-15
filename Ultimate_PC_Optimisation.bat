@echo off
title ULTIMATE PACK - Optimisation Totale PC Gaming
color 0E

:: =============== CPU ===============
echo [CPU] Activation du plan de performance maximale...
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

echo [CPU] Optimisation des timers...
bcdedit /set useplatformclock true
bcdedit /set disabledynamictick yes
bcdedit /set useplatformtick yes
bcdedit /set tscsyncpolicy Enhanced
bcdedit /set nx AlwaysOff
bcdedit /set hypervisorlaunchtype off

:: =============== RAM ===============
echo [RAM] Désactivation du fichier d’échange...
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
wmic pagefileset where name="C:\\pagefile.sys" delete
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f

:: =============== NVIDIA ===============
echo [NVIDIA] Réglages de performance...
reg add "HKLM\\SYSTEM\\CurrentControlSet\\Services\\nvlddmkm\\FTS" /v EnableRID575 /t REG_DWORD /d 1 /f
reg add "HKCU\\Software\\NVIDIA Corporation\\Global\\NGXCore" /v ShowDLSSIndicator /t REG_DWORD /d 0 /f
reg add "HKLM\\SOFTWARE\\NVIDIA Corporation\\Global\\NvCplApi\\Policies" /v ContextUIPolicy /t REG_DWORD /d 1 /f

echo [NVIDIA] Suppression du cache shader...
del /f /s /q "%LocalAppData%\\NVIDIA\\DXCache\\*.*"
del /f /s /q "%LocalAppData%\\NVIDIA\\GLCache\\*.*"

:: =============== LATENCE + RESEAU ===============
echo [Latence] Optimisation du TCP/IP...
netsh int tcp set global rss=enabled
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global ecncapability=disabled
netsh int tcp set global timestamps=disabled
netsh int tcp set global chimney=enabled

echo [Latence] Désactivation services inutiles...
sc stop DiagTrack
sc config DiagTrack start= disabled
sc stop dmwappushservice
sc config dmwappushservice start= disabled
reg add "HKLM\\SYSTEM\\ControlSet001\\Services\\Ndu" /v Start /t REG_DWORD /d 4 /f

:: =============== STOCKAGE / TEMP FILES ===============
echo [Stockage] Nettoyage des fichiers temporaires...
del /f /s /q %temp%\\*.*
del /f /s /q C:\\Windows\\Temp\\*.*

:: =============== FIN ===============
echo Optimisation ULTIME terminée ! Redémarre ton PC pour tout appliquer.
pause
