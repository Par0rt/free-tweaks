
@echo off
title Réduction Latence Système - Ultimate Tweak
color 0C

:: Activer le timer haute précision
bcdedit /set useplatformclock true
bcdedit /set disabledynamictick yes
bcdedit /set useplatformtick yes
bcdedit /set tscsyncpolicy Enhanced

:: Désactiver les services de télémétrie et diagnostics
sc stop DiagTrack
sc config DiagTrack start= disabled
sc stop dmwappushservice
sc config dmwappushservice start= disabled

:: Désactiver NDU (Network Diagnostic Usage)
reg add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v Start /t REG_DWORD /d 4 /f

:: Mettre les périphériques en performance max (clavier/souris)
powercfg -devicequery wake_from_any > devices.txt
for /f "tokens=*" %%i in (devices.txt) do (
    powercfg -devicedisablewake "%%i"
)

:: Optimiser les buffers TCP/IP (latence réseau)
netsh int tcp set global rss=enabled
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global ecncapability=disabled
netsh int tcp set global timestamps=disabled
netsh int tcp set global chimney=enabled

:: Activer MSI Mode (nécessite redémarrage + vérification manuelle)
echo Tu peux maintenant passer ta carte graphique en MSI Mode avec MSI_util_v3

echo Latence réduite. Redémarre ton PC pour finaliser les changements.
pause
