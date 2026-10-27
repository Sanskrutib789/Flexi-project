@echo off
TITLE FLEXI Jewelry Launcher
COLOR 06
echo ======================================================================
echo             FLEXI JEWELRY - HAUTE JOAILLERIE PLATFORM
echo ======================================================================
echo.
echo Starting FLEXI Jewelry full-stack environment...
echo.
echo 1. Launching Express Backend Server (Port 5000)...
start "FLEXI Jewelry - Backend (Port 5000)" cmd /k "cd backend && npm run start"

timeout /t 2 /nobreak >nul

echo 2. Launching Vite React Frontend (Port 5173)...
start "FLEXI Jewelry - Frontend (Port 5173)" cmd /k "cd frontend && npm run dev"

echo.
echo Full-stack environment started!
echo Frontend: http://localhost:5173
echo Backend API: http://localhost:5000
echo.
echo Note: If you have not seeded the database yet, run: seed-database.bat
echo ======================================================================
pause
