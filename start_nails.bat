@echo off
SETLOCAL EnableDelayedExpansion

echo ====================================================
echo    Nail Booking Bot - Quick Start
echo ====================================================

:: 1. Проверка Docker
echo Checking for Docker...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not installed or not running!
    echo Please install Docker Desktop: https://www.docker.com/products/docker-desktop/
    echo After installation, make sure Docker is started.
    pause
    exit /b
)
echo [OK] Docker is installed.

:: 2. Проверка .env файла
if not exist .env (
    echo [INFO] .env file not found. Creating a template...
    (
        echo DATABASE_URL=mysql://root:password@db:3306/nails
        echo TELEGRAM_BOT_TOKEN=YOUR_BOT_TOKEN_HERE
        echo ADMIN_TELEGRAM_ID=YOUR_TELEGRAM_ID_HERE
        echo MINI_APP_URL=http://localhost:3000
        echo JWT_SECRET=change_me_to_something_random_123
        echo VITE_APP_ID=your_app_id
        echo OAUTH_SERVER_URL=your_oauth_url
        echo VITE_OAUTH_PORTAL_URL=your_portal_url
    ) > .env
    echo [SUCCESS] .env template created. 
    echo [!] IMPORTANT: Open .env and replace YOUR_BOT_TOKEN_HERE with your real token from @BotFather.
    pause
) else (
    echo [OK] .env file found.
)

:: 3. Запуск проекта
echo Starting the project with Docker Compose...
docker-compose up -d

echo.
echo ====================================================
echo    Project is launching in the background!
echo ====================================================
echo.
echo 1. Wait about 30-60 seconds for the database to start.
echo 2. Open your browser and go to: http://localhost:3000
echo 3. If you changed the .env file, run: docker-compose restart
echo.
echo To stop the project, run: docker-compose down
echo.
pause
