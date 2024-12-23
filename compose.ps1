$thisDir = $PSScriptRoot

function Show-Yml {
    param($yml)
    $file = $yml -replace 'docker-compose-', '' -replace '\.yml$', ''
    Write-Host $file
}

function List-Yml {
    Push-Location $thisDir
    Get-ChildItem -Filter "*.yml" | ForEach-Object { Show-Yml $_.Name }
    $script:composename = Read-Host "Compose Name ?"
    Pop-Location
}

$composename = $args[0]
if ([string]::IsNullOrEmpty($composename)) {
    List-Yml
}

if ([string]::IsNullOrEmpty($composename)) {
    Write-Host "composename not set"
    exit 1
}

Push-Location $thisDir
$composeFile = "docker-compose-$composename.yml"
Write-Host "executing docker compose -- $composeFile"

if (-not (Test-Path $composeFile)) {
    Write-Host "'$composeFile' not found"
    exit 1
}

docker compose -f $composeFile up -d
docker ps --format "table {{.ID}}`t{{.Image}}`t{{.Names}}`t{{.Status}}`t{{.Ports}}"
Pop-Location