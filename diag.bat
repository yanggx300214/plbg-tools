@echo off
setlocal
set OUT=D:\WorkBuddy\2026-09-17-15-25-55\plbg-tools-web\diag.txt
set GIT=C:\Users\15863\.workbuddy\binaries\PortableGit\versions\1.2.0\cmd\git.exe
set SSH=C:\Users\15863\.workbuddy\binaries\PortableGit\versions\1.2.0\bin\ssh.exe

echo ===== PLBG push diagnostics ===== > %OUT%
echo %DATE% %TIME% >> %OUT%
echo. >> %OUT%
echo ----- git version ----- >> %OUT%
%GIT% --version >> %OUT% 2>&1
echo. >> %OUT%
echo ----- git global config (look for http.proxy / credential) ----- >> %OUT%
%GIT% config --global --list >> %OUT% 2>&1
echo. >> %OUT%
echo ----- proxy env vars (blank = none) ----- >> %OUT%
set | findstr /i proxy >> %OUT% 2>&1
echo. >> %OUT%
echo ----- HTTPS ls-remote WITHOUT proxy override ----- >> %OUT%
%GIT% -c http.proxy= -c https.proxy= ls-remote https://github.com/yanggx300214/plbg-tools.git >> %OUT% 2>&1
echo. >> %OUT%
echo ----- HTTPS ls-remote WITH default config ----- >> %OUT%
%GIT% ls-remote https://github.com/yanggx300214/plbg-tools.git >> %OUT% 2>&1
echo. >> %OUT%
echo ----- SSH connectivity test (10s) ----- >> %OUT%
%SSH% -T -o ConnectTimeout=10 -o StrictHostKeyChecking=no -o BatchMode=yes git@github.com >> %OUT% 2>&1
echo. >> %OUT%
echo ----- done ----- >> %OUT%
echo Diagnostics finished. See diag.txt
pause