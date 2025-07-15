
@echo off
title Optimisation Processeur pour FPS
color 0A

:: Activer mode performances maximales
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

:: Activer le planificateur haute performance
bcdedit /set useplatformclock true
bcdedit /set disabledynamictick yes
bcdedit /set useplatformtick yes

:: Réduction de la latence du processeur
bcdedit /set tscsyncpolicy Enhanced
bcdedit /set nx AlwaysOff

:: Activer les instructions CPU modernes
bcdedit /set hypervisorlaunchtype off

:: Forcer la priorité des tâches en arrière-plan
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 26 /f

:: Augmenter la priorité du jeu (exemple avec Fortnite)
wmic process where name="FortniteClient-Win64-Shipping.exe" CALL setpriority "high priority"

echo Optimisation CPU terminée.
pause
