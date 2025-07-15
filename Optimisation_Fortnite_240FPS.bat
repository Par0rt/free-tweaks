
@echo off
:: 🎯 OPTIMISATION FORTNITE - FPS MAX + VISIBILITÉ + LATENCE BASSE

:: 1. Activer Performances Maximales
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

:: 2. Désactiver GameDVR
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f

:: 3. Forcer le GPU dédié (si portable)
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v "FortniteClient-Win64-Shipping.exe" /t REG_SZ /d "GpuPreference=1;" /f

:: 4. Supprimer le cache de Fortnite (réinitialise les shaders & bugs)
rd /s /q "%localappdata%\FortniteGame\Saved\Cache"
rd /s /q "%localappdata%\FortniteGame\Saved\Logs"
rd /s /q "%localappdata%\FortniteGame\Saved\WebCache"
del /f /q "%localappdata%\FortniteGame\Saved\Config\WindowsClient\GameUserSettings.ini"

:: 5. Nettoyage des fichiers temp Windows
del /f /s /q %temp%\*
del /f /s /q C:\Windows\Temp\*

:: 6. Optimiser réseau : DNS + MTU + QoS désactivé
netsh int tcp set global autotuninglevel=normal
netsh interface tcp set global rss=enabled
netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent
netsh interface ipv6 set subinterface "Ethernet" mtu=1500 store=persistent

:: 7. Activer mode faible latence Nvidia (manuel si besoin)
:: --> Doit être activé dans le panneau NVIDIA aussi

echo.
echo ✅ OPTIMISATION TERMINÉE POUR FORTNITE - REDÉMARRE TON PC
pause
