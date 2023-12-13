@echo off
SETLOCAL
set thisDir=%~dp0
set thisDir=%thisDir:~0,-1%

set composename=%~1
if "%composename%"=="" set /p composename=Compose Name - ie mysql ? 

if "%composename%"=="" echo composename not set & exit /b 1

pushd "%thisDir%"
set composeFile=docker-compose-%composename%.yml
echo executing docker compose -- %composeFile%
docker compose -f %composeFile% down
popd

ENDLOCAL