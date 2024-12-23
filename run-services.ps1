# =================================================
# This will run compose up
# =================================================


$parentPath= Split-Path $PSScriptRoot -Parent

$services = @(
    'azurite'
    'sqlserver'
)

function Compose-Up-Service {

    param (
        $RepoPath
    )

    Write-Host Processing $RepoPath ..
    $filePath = "docker-compose-$RepoPath.yml"
    $composeFile = Join-Path $PSScriptRoot $filePath

    if (Test-Path $composeFile) {
        docker compose -f $composeFile up -d
    } else {
        Write-Host "could not find $composeFile"
        exit
    }
}


foreach ($service in $services) {
    Compose-Up-Service $service
}