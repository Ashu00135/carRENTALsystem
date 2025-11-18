@echo off
REM CarRentalSystem Build & Run Script for Windows Command Prompt
REM Usage: build-run.bat [action] [options]

setlocal enabledelayedexpansion

if "%~1"=="" (
    set ACTION=help
) else (
    set ACTION=%~1
)

if "%~2"=="" (
    set PORT=8080
) else (
    set PORT=%~2
)

set SKIP_TESTS=0
if "%~3"=="--skipTests" set SKIP_TESTS=1

REM Get script directory
set SCRIPT_DIR=%~dp0
set PROJECT_DIR=%SCRIPT_DIR%CarRentalSystem

echo.
echo ========================================
echo   Car Rental System - Build & Run
echo ========================================
echo.

REM Check Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Java not found! Please install Java 17 or later.
    exit /b 1
)
echo [OK] Java found

REM Check Maven
mvn -v >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Maven not found! Please install Maven 3.9 or later.
    exit /b 1
)
echo [OK] Maven found
echo.

if /i "%ACTION%"=="build" goto BUILD
if /i "%ACTION%"=="run" goto RUN
if /i "%ACTION%"=="dev" goto DEV
if /i "%ACTION%"=="clean" goto CLEAN
if /i "%ACTION%"=="build-run" goto BUILD_RUN
if /i "%ACTION%"=="dependencies" goto DEPENDENCIES
if /i "%ACTION%"=="help" goto HELP
goto HELP

:BUILD
echo [*] Building project...
cd /d "%PROJECT_DIR%"
if %SKIP_TESTS% equ 1 (
    mvn -DskipTests package
) else (
    mvn package
)
if %errorlevel% equ 0 (
    echo [OK] Build successful!
) else (
    echo [ERROR] Build failed!
    exit /b 1
)
exit /b 0

:RUN
echo [*] Starting Spring Boot application on port %PORT%...
set JAR_PATH=%PROJECT_DIR%\target\carrental-0.0.1-SNAPSHOT.jar
if not exist "%JAR_PATH%" (
    echo [ERROR] JAR not found at: %JAR_PATH%
    echo [INFO] Please run 'build' action first.
    exit /b 1
)
echo [INFO] JAR: %JAR_PATH%
echo [INFO] Press Ctrl+C to stop the application
echo.
java -jar "%JAR_PATH%" --server.port=%PORT%
exit /b 0

:DEV
echo [*] Starting in development mode with hot reload...
echo [INFO] Press Ctrl+C to stop
echo.
cd /d "%PROJECT_DIR%"
mvn spring-boot:run -Dspring-boot.run.arguments="--server.port=%PORT%"
exit /b 0

:CLEAN
echo [*] Cleaning build artifacts...
cd /d "%PROJECT_DIR%"
mvn clean
if %errorlevel% equ 0 (
    echo [OK] Clean successful!
) else (
    echo [ERROR] Clean failed!
    exit /b 1
)
exit /b 0

:BUILD_RUN
echo [*] Building and running project...
cd /d "%PROJECT_DIR%"
if %SKIP_TESTS% equ 1 (
    mvn -DskipTests package
) else (
    mvn package
)
if %errorlevel% neq 0 (
    echo [ERROR] Build failed!
    exit /b 1
)
echo [OK] Build successful!
echo.
echo [*] Starting application on port %PORT%...
set JAR_PATH=%PROJECT_DIR%\target\carrental-0.0.1-SNAPSHOT.jar
echo [INFO] Press Ctrl+C to stop the application
echo.
java -jar "%JAR_PATH%" --server.port=%PORT%
exit /b 0

:DEPENDENCIES
echo.
echo === Project Dependencies ===
echo.
echo Spring Boot Version: 3.3.4
echo Java Version: 17
echo.
echo Core Dependencies:
echo   - spring-boot-starter-web        [Web ^& REST API support]
echo   - spring-boot-starter-data-jpa   [Database ^& ORM]
echo   - spring-boot-starter-thymeleaf  [Template engine for HTML]
echo   - h2database                      [In-memory database for development]
echo.
echo To view full dependency tree, run:
echo   mvn dependency:tree
echo.
echo To see resolved dependencies, run:
echo   cd CarRentalSystem
echo   mvn dependency:resolve
echo.
exit /b 0

:HELP
echo.
echo === Car Rental System - Build & Run Help ===
echo.
echo Usage: build-run.bat [action] [port] [options]
echo.
echo Actions:
echo   build         Build the project (creates JAR)
echo   run           Run the built JAR application
echo   dev           Build and run with Spring Boot dev mode (hot reload)
echo   clean         Clean build artifacts
echo   build-run     Build then run (default action)
echo   dependencies  Show project dependencies
echo   help          Show this help message
echo.
echo Options:
echo   port          Specify server port (default: 8080)
echo   --skipTests   Skip running tests during build
echo.
echo Examples:
echo   build-run.bat build                    # Build only
echo   build-run.bat run 9090                 # Run on port 9090
echo   build-run.bat dev                      # Dev mode with hot reload
echo   build-run.bat build-run                # Build and run
echo   build-run.bat clean                    # Clean build files
echo   build-run.bat dependencies             # List dependencies
echo.
exit /b 0
