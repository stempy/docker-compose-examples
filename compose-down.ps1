# Get the directory of the script
$thisDir = $PSScriptRoot

# Get the compose name from the command line argument or prompt the user
$composeName = $args[0]
if (-not $composeName) {
    $composeName = Read-Host "Compose Name - ie mysql"
}

# Check if composeName is still empty
if (-not $composeName) {
    Write-Host "composeName not set"
    exit 1
}

# Change to the script's directory
Push-Location $thisDir

# Set the compose file name
$composeFile = "docker-compose-$composeName.yml"

# Execute docker compose down
Write-Host "executing docker compose -- $composeFile"
docker compose -f $composeFile down

# Return to the original directory
Pop-Location