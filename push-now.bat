@echo off
REM ============================================================
REM  PLBG tools - one-click push via SSH
REM  SSH bypasses the HTTPS 502 proxy that blocks normal push.
REM  Double-click after you have added your PUBLIC key to GitHub.
REM ============================================================
set GIT="C:\Users\15863\.workbuddy\binaries\PortableGit\versions\1.2.0\cmd\git.exe"
set SSH="C:\Users\15863\.workbuddy\binaries\PortableGit\versions\1.2.0\bin\ssh.exe"
cd /d "D:\WorkBuddy\2026-09-17-15-25-55\plbg-tools-web"

REM 确保 github.com 已加入 known_hosts（避免首次连接交互询问）
%SSH% -o StrictHostKeyChecking=no -o BatchMode=yes git@github.com >nul 2>&1

REM 让 git 调 ssh 时也不询问 host key
set GIT_SSH_COMMAND=ssh -o StrictHostKeyChecking=no

REM 指向 SSH 地址（不走 HTTPS 代理）
%GIT% remote set-url origin git@github.com:yanggx300214/plbg-tools.git

echo.
echo Pushing to GitHub via SSH...
echo.
%GIT% push -u origin main
if errorlevel 1 (
  echo.
  echo [!] Push failed. Please confirm:
  echo     1) Your SSH PUBLIC key is added to GitHub
  echo        (GitHub - Settings - SSH and GPG keys - New SSH key)
  echo     2) The key file exists at C:\Users\15863\.ssh\id_ed25519
  echo.
) else (
  echo.
  echo [OK] Push succeeded. Deployment starts automatically.
  echo      Open: https://yanggx300214.github.io/plbg-tools/  (wait ~1 min)
)
pause
