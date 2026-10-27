@echo off
TITLE FLEXI Jewelry - Promote User to Administrator
COLOR 0D
echo ======================================================================
echo              FLEXI JEWELRY - ADMIN PRIVILEGE PROMOTION TOOL
echo ======================================================================
echo.
set /p userEmail="Enter the email address of the user to promote: "
if "%userEmail%"=="" (
    echo Error: No email provided. Aborting.
    pause
    exit /b 1
)

echo.
echo Promoting %userEmail% to Administrator...
cd backend
node scripts/promoteAdmin.js %userEmail%
echo.
pause
