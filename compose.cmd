@echo off
SETLOCAL
set thisDir=%~dp0
set thisDir=%thisDir:~0,-1%

set composename=%~1
if "%composename%"=="" call :listyml 
REM set /p composename=Compose Name - ie mysql ? 
goto :go

:listyml
pushd "%thisDir%"
for %%a in (*.yml) do call :showyml %%a
set /p composename=Compose Name ?
popd
exit /b 1

:showyml
set yml=%~1
set file=%yml:docker-compose-=%
set file=%file:.yml=%
echo %file%
exit /b 1

:go
if "%composename%"=="" echo composename not set & exit /b 1

pushd "%thisDir%"
set composeFile=docker-compose-%composename%.yml
echo executing docker compose -- %composeFile%
if NOT exist %composeFile% echo "%composeFile%" not found & exit /b 1
docker compose -f %composeFile% up -d
docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"
popd
goto :end


:end
ENDLOCAL