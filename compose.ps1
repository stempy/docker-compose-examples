param(
    [Parameter(ValueFromRemainingArguments=$true)]    
    [string[]]$ComposeFiles = @()
)
$thisDir = $PSScriptRoot
$dockerDir = $thisDir

function List-Yml {
    Push-Location $dockerDir
    Get-ChildItem -Filter "*.yml" | ForEach-Object { 
        $displayName = $_.Name -replace '^docker-compose-', '' -replace '\.yml$', ''
        Show-Yml $displayName 
    }    
    Pop-Location
}

function Compose {
    param(
        [string]$ComposeName
    )

    if (-not $ComposeName.StartsWith("docker-compose-")) {
        $ComposeName = "docker-compose-$ComposeName"
    }
    if (-not $ComposeName.EndsWith(".yml")) {
        $ComposeName = "$ComposeName.yml"
    }


    $composeFile = Join-Path $dockerDir $ComposeName
    if (Test-Path $composeFile) {
        Write-Host "Running docker compose with file: $composeFile"
        docker compose -f $composeFile up -d
    } else {
        Write-Host "Compose file not found: $composeFile"
    }
}
function Show-Yml {
    param(
        [string]$YmlName
    )
    Write-Host "YML File: $YmlName"
}

# Check if any compose files were provided
if ($ComposeFiles.Count -eq 0) {
    Write-Host "No compose files provided. Listing available YML files:"
    List-Yml
    $ComposeFiles = Read-Host "Enter the names of the compose files to run (space-separated)"
    $ComposeFiles = $ComposeFiles -split " \s*"
}

foreach ($file in $ComposeFiles) {
    Compose -ComposeName $file
}

docker ps --format "table {{.ID}}`t{{.Image}}`t{{.Names}}`t{{.Status}}`t{{.Ports}}"

