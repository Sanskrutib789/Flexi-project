@echo off
TITLE FLEXI Jewelry - Database Seeding Utility
COLOR 0E
echo ======================================================================
echo              FLEXI JEWELRY - MONGODB SEEDING UTILITY
echo ======================================================================
echo.
echo Populating MongoDB with High Jewelry catalog pieces, admin account,
echo demo customer account, initial order, and client inquiries...
echo.
cd backend
npm run seed
echo.
echo Seeding routine finished.
pause
