@echo off
chcp 65001 > nul
:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Программа должна быть запущена от имени АДМИНИСТРАТОРА!
    echo Нажмите правой кнопкой мыши по файлу и выберите "Запуск от имени администратора".
    pause
    exit /b
)

echo Обновление блокировки серверов STALCRAFT МСК-2...

:: Удаление старого правила, если оно существовало
netsh advfirewall firewall delete rule name="STALCRAFT MSK BLOCK" >nul 2>&1

:: Список IP-адресов и диапазонов МСК-2 (включая новые подсети)
set "IPS=85.119.148.0/24,85.119.149.0/24,85.119.150.0/24,85.119.144.0/22,95.213.252.0/22,95.216.0.0/16,94.130.0.0/16,135.181.0.0/16,45.143.200.0/22"

:: Создание нового правила для ВСЕХ программ по UDP портам
netsh advfirewall firewall add rule name="STALCRAFT MSK BLOCK" direction=out action=block protocol=UDP remoteport=29450-29460 remoteip=%IPS%

echo.
echo ===================================================
echo  Правило "STALCRAFT MSK BLOCK" успешно обновлено!
echo  Все известные IP-адреса МСК-2 заблокированы.
echo ===================================================
echo.
pause
