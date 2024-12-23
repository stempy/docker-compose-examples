$dockerTmp = Join-Path $PSScriptRoot ".docker"
$dockerTmp = Join-Path $dockerTmp "sql"
$dockerCompose = Join-Path $PSScriptRoot "docker-compose-sqlserver.yml"

Write-Host "$dockerTmp"

docker compose -f $dockerCompose down
# REMOVE SQL SERVER DATA
Get-ChildItem -Path "$dockerTmp" -Recurse | Remove-Item -force -recurse

docker compose -f $dockerCompose up -d
