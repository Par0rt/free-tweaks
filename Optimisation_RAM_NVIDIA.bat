
@echo off
title Optimisation RAM + NVIDIA pour FPS Max
color 0B

:: ---------------------------
:: PARTIE 1 : Optimisation de la RAM
:: ---------------------------

:: Désactiver le fichier d’échange si 16 Go ou plus
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
wmic pagefileset where name="C:\pagefile.sys" delete

:: Activer le ClearPageFileAtShutdown (vide la RAM à l’arrêt)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f

:: Forcer l'utilisation de la RAM physique avant le swap
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f

:: ---------------------------
:: PARTIE 2 : NVIDIA - Réglages de performance
:: ---------------------------

:: Activer le mode performance maximale dans le panneau NVIDIA (via registre)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS" /v EnableRID575 /t REG_DWORD /d 1 /f

:: Désactiver le cache de compilation lent
reg add "HKCU\Software\NVIDIA Corporation\Global\NGXCore" /v ShowDLSSIndicator /t REG_DWORD /d 0 /f

:: Activer Low Latency Mode (si disponible dans drivers)
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NvCplApi\Policies" /v ContextUIPolicy /t REG_DWORD /d 1 /f

:: Supprimer le cache des shaders (peut corriger stutter)
del /f /s /q "%LocalAppData%\NVIDIA\DXCache\*.*"
del /f /s /q "%LocalAppData%\NVIDIA\GLCache\*.*"

:: Nettoyer la mémoire standby (optionnel, si ISLC non utilisé)
echo Vide la mémoire standby
PowerShell -Command "Clear-Content -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters' -Force"

echo Optimisation NVIDIA + RAM terminée.
pause
