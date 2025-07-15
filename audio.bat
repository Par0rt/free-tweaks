@echo off
title Optimisation Audio Windows - Faible latence
color 0A

echo.
echo ==== Optimisation audio en cours... ====
echo.

:: Désactiver les effets audio Windows
REG ADD "HKCU\Software\Microsoft\Multimedia\Audio" /v DisableAudioEnhancements /t REG_DWORD /d 1 /f

:: Activer le mode exclusif audio (permet à un jeu d'accéder directement à l'audio sans délai)
REG ADD "HKCU\Software\Microsoft\Multimedia\Audio" /v ExclusiveMode /t REG_DWORD /d 1 /f

:: Baisser la latence du buffer audio (mode faible latence WASAPI)
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render" /v AudioLatency /t REG_DWORD /d 1 /f

:: Forcer le plan d’alimentation haute performance
powercfg /setactive SCHEME_MIN

:: Réduction des services inutiles pour l’audio
sc config Audiosrv start= auto
sc config AudioEndpointBuilder start= auto
sc stop SysMain
sc config SysMain start= disabled

:: Optimisation du thread audio dans MMCSS
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "SFIO Priority" /t REG_SZ /d "High" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Background Only" /t REG_SZ /d "False" /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Clock Rate" /t REG_DWORD /d 10000 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "GPU Priority" /t REG_DWORD /d 8 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d 6 /f

echo.
echo ==== Optimisation audio appliquee ! ====
echo Redemarre ton PC pour que tout prenne effet.
pause
