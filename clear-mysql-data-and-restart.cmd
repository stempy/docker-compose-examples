@echo off
SETLOCAL
set thisDir=%~dp0
set thisDir=%thisDir:~0,-1%
set mysqlData=%thisDir%\.docker\mysql

Echo Clearing Mysql Data....

pushd "%thisDir%"
call compose-down mysql
RMDIR "%mysqlData%" /S /Q
if NOT exist "%mysqData%" echo Success... folder removed
call compose mysql
popd
ENDLOCAL
