@echo off
color 0A
title OPTIMISATION ULTIME WINDOWS

:: Activer performance maximale
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

:: Désactiver services inutiles
sc stop "SysMain"
sc config "SysMain" start= disabled
sc stop "DiagTrack"
sc config "DiagTrack" start= disabled

:: Timer haute précision
bcdedit /set useplatformclock true
bcdedit /set disabledynamictick yes
bcdedit /set useplatformtick yes

:: Désactiver services Xbox
Get-AppxPackage *xbox* | Remove-AppxPackage

:: Optimiser réseau (ping)
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global rss=enabled
netsh int tcp set global chimney=enabled

:: Priorité élevée pour Fortnite (exemple)
wmic process where name="FortniteClient-Win64-Shipping.exe" CALL setpriority "high priority"

pause
