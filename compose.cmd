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
if NOT exist %composeFile% echo "%composeFile%" not found & exit /b 1
docker compose -f %composeFile% up -d
docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"
popd

ENDLOCAL