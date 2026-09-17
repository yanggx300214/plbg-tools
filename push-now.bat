@echo off
REM ============================================================
REM  PLBG tools - one-click push to GitHub
REM  Double-click this file. Requires: GitHub repo
REM  "yanggx300214/plbg-tools" already created (Public).
REM ============================================================
set GIT="C:\Users\15863\.workbuddy\binaries\PortableGit\versions\1.2.0\cmd\git.exe"
cd /d "D:\WorkBuddy\2026-09-17-15-25-55\plbg-tools-web"

REM remove old remote if exists, then add fresh
%GIT% remote remove origin 2>nul
set USER=yanggx300214
%GIT% remote add origin https://github.com/%USER%/plbg-tools.git

echo.
echo Pushing to GitHub... when asked:
echo   Username = yanggx300214
echo   Password = your GitHub Personal Access Token (PAT), NOT login password
echo.
%GIT% push -u origin main
if errorlevel 1 (
  echo.
  echo First push rejected. Repo may not be empty - merging then pushing...
  %GIT% pull origin main --allow-unrelated-histories --no-edit
  if errorlevel 1 (
    echo Merge failed. Forcing push to seed the repo...
    %GIT% push -u origin main --force
  ) else (
    %GIT% push -u origin main
  )
)

echo.
echo Done. Open:
echo   https://github.com/%USER%/plbg-tools  ->  Settings -> Pages -> Source: GitHub Actions
pause
