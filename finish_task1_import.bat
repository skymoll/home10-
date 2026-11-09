@echo off
setlocal
chcp 65001 >nul

echo === Задача 1: импорт лендинга в Git ===
echo Запусти этот файл из папки Site For Import после распаковки landing.zip.
echo Сначала на GitHub создай новый ПУСТОЙ публичный репозиторий.
echo.

if not exist .gitignore (
  (
    echo tmp/
    echo *_old*
    echo *_backup*
    echo Thumbs.db
    echo .DS_Store
  ) > .gitignore
) else (
  echo .gitignore уже существует. Скрипт не будет его перезаписывать.
)

if not exist .git (
  git init
  if errorlevel 1 goto failed
) else (
  echo В этой папке уже есть репозиторий Git.
)

git branch -M main
if errorlevel 1 goto failed

echo.
echo Проверка статуса до добавления файлов:
git status

git add .
if errorlevel 1 goto failed

echo.
echo Проверка подготовленных файлов:
git status

git commit -m "Import landing project"
if errorlevel 1 goto failed

echo.
set /p ORIGIN_URL=Вставь SSH- или HTTPS-ссылку на пустой GitHub-репозиторий: 
if "%ORIGIN_URL%"=="" goto failed

git remote add origin "%ORIGIN_URL%"
if errorlevel 1 goto failed

git push -u origin main
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
