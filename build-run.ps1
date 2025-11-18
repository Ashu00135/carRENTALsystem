param([string]$action = "help", [string]$port = "8080", [switch]$skipTests)

$c = @{G = [ConsoleColor]::Green; R = [ConsoleColor]::Red; Y = [ConsoleColor]::Yellow; C = [ConsoleColor]::Cyan}

function Out-Color { param($m, $c) Write-Host $m -ForegroundColor $c }

function Help-Text {
    Out-Color "`nCar Rental System" $c.C
    Write-Host "Usage: .\build-run.ps1 [action]"
    Write-Host "build    - Build project"
    Write-Host "run      - Run application"
    Write-Host "dev      - Dev mode"
    Write-Host "clean    - Clean build"
    Write-Host "build-run- Build & run`n"
}

function Setup-Maven {
    $global:mvn = $null
    if ((Get-Command mvn -ErrorAction SilentlyContinue)) {
        $global:mvn = "mvn"
        return
    }
    $path = "C:\ProgramData\chocolatey\lib\maven\apache-maven-3.9.9\bin\mvn.cmd"
    if (Test-Path $path) {
        $global:mvn = $path
        return
    }
    Out-Color "Maven not found" $c.R
    exit 1
}

function Build {
    Out-Color "`nBuilding..." $c.Y
    cd "$PSScriptRoot\CarRentalSystem"
    if ($skipTests) {
        & $global:mvn -DskipTests package 2>&1 | Out-Null
    } else {
        & $global:mvn package 2>&1 | Out-Null
    }
    if ($LASTEXITCODE -eq 0) {
        Out-Color "Build OK" $c.G
        return $true
    }
    Out-Color "Build failed" $c.R
    return $false
}

function Run-App {
    $jar = "$PSScriptRoot\CarRentalSystem\target\carrental-0.0.1-SNAPSHOT.jar"
    if (!(Test-Path $jar)) {
        Out-Color "JAR not found. Build first." $c.R
        return
    }
    Out-Color "`nStarting on port $port..." $c.Y
    java -jar $jar --server.port=$port
}

function Dev-Mode {
    Out-Color "`nDev mode..." $c.Y
    cd "$PSScriptRoot\CarRentalSystem"
    & $global:mvn spring-boot:run -Dspring-boot.run.arguments="--server.port=$port"
}

function Clean {
    Out-Color "`nCleaning..." $c.Y
    cd "$PSScriptRoot\CarRentalSystem"
    & $global:mvn clean 2>&1 | Out-Null
    Out-Color "Done" $c.G
}

Setup-Maven
switch ($action.ToLower()) {
    "build" { Build }
    "run" { Run-App }
    "dev" { Dev-Mode }
    "clean" { Clean }
    "build-run" { if (Build) { Run-App } }
    default { Help-Text }
}
