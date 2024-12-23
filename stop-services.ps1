# =================================================
# This will run multiple docker compose
# =================================================

$parentPath= Split-Path $PSScriptRoot -Parent

$services = @(
    'azurite'
    'sqlserver'
)

function Compose-Down-Service {

    param (
        $RepoPath
    )

    Write-Host Processing $RepoPath ..
    $filePath = "docker-compose-$RepoPath.yml"
    $composeFile = Join-Path $PSScriptRoot $filePath

    if (Test-Path $composeFile) {
        docker compose -f $composeFile down
    } else {
        Write-Host "could not find $composeFile"
        exit
    }
}


foreach ($service in $services) {
    Compose-Down-Service $service
}