function Run-DockerComposeInSubdirectories {
    param (
        [Parameter(Mandatory=$true)]
        [string]$basePath,
        
        [Parameter(Mandatory=$false)]
        [string[]]$excludedDirectories = @(),
        
        [Parameter(Mandatory=$false)]
        [string[]]$includedDirectories = @()
    )

    # Get all directories in the base path
    $directories = Get-ChildItem -Path $basePath -Directory

    # Loop through each directory
    foreach ($dir in $directories) {
        # Skip excluded directories if any are specified
        if ($excludedDirectories -and ($excludedDirectories -contains $dir.Name)) {
            Write-Host "Skipping excluded directory: $($dir.Name)"
            continue
        }

        # Process only included directories if specified
        if ($includedDirectories -and -not ($includedDirectories -contains $dir.Name)) {
            # Write-Host "Skipping non-included directory: $($dir.Name)"
            continue
        }

        # Check if docker-compose.yml exists in the current directory
        $dockerComposeFile = Join-Path $dir.FullName "docker-compose.yml"
        
        if (Test-Path $dockerComposeFile) {
            Write-Host "Found docker-compose.yml in $($dir.FullName)"
            
            # Change to the directory containing docker-compose.yml
            Push-Location $dir.FullName
            
            # Run docker compose up -d
            Write-Host "Running 'docker compose up -d' in $($dir.FullName)"
            docker compose up -d
            
            # Change back to the original directory
            Pop-Location
        }
    }

    Write-Host "Finished processing all directories."
}


# Verify that the base path exists
if (-not (Test-Path $basePath)) {
    Write-Host "Error: The specified path does not exist: $basePath"
    exit 1
}

# Define excluded directories
$excludedDirectories = @(
    "node_modules",
    "vendor",
    "build",
    "dist"
)  # Add directory names here that you want to exclude

# Define included directories (optional)
$includedDirectories = @(
   # add directory names
)  # Add directory names here if you want to include specific ones

# Call the function with the base path, and optionally excluded and included directories
Run-DockerComposeInSubdirectories -basePath $basePath -excludedDirectories $excludedDirectories -includedDirectories $includedDirectories
