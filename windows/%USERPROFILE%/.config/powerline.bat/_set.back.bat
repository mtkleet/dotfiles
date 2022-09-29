    @echo off

    set GITBRANCH=
    for /f "tokens=2" %%I in ('git.exe branch 2^> NUL ^| findstr /b "* "') do set GITBRANCH=%%I

    if "%GITBRANCH%" == "" (
        prompt $E[30m;44m$S$E[0m$E[30m;44m$P$S$E[0m$E[34m$E[0m$S
    ) else (
        prompt $E[30m;44m$S$E[0m$E[30m;44m$P$S$E[0m$E[34m;43m$S$E[0m$E[30;43m%GITBRANCH%$S$E[0m$E[33m$E[0m$S
    )
