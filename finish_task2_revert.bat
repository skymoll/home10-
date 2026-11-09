@echo off
setlocal
chcp 65001 >nul

echo === Задача 2: отмена последнего коммита ===
echo Сначала создай на GitHub новый ПУСТОЙ публичный репозиторий.
echo Скопируй его SSH- или HTTPS-ссылку.
echo.

if exist git-2-homeworks-revert (
  echo Папка git-2-homeworks-revert уже существует.
  echo Удали или переименуй её, затем запусти скрипт снова.
  pause
  exit /b 1
)

git clone https://github.com/netology-code/git-2-homeworks-revert.git
if errorlevel 1 goto failed
cd git-2-homeworks-revert
if errorlevel 1 goto failed

echo.
echo Текущий последний коммит будет отменён командой git revert.
git revert --no-edit HEAD
if errorlevel 1 goto failed

echo.
set /p TARGET_URL=Вставь ссылку на свой новый пустой GitHub-репозиторий: 
if "%TARGET_URL%"=="" goto failed

git remote add target "%TARGET_URL%"
if errorlevel 1 goto failed

git push -u target main
if errorlevel 1 goto failed

echo.
echo Готово! Проверь репозиторий на GitHub.
pause
exit /b 0

:failed
echo.
echo Возникла ошибка. Скопируй текст терминала и пришли его мне.
pause
exit /b 1
