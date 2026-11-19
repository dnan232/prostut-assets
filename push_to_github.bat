@echo off
chcp 65001 >nul
title Prostut - GitHub Assets Push Script
echo ===============================================================
echo     Prostut Question Assets to GitHub CDN Uploader
echo ===============================================================
echo.

where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [!] Git is not installed or not in PATH!
    echo.
    echo Please install Git for Windows first:
    echo 1. Download from: https://git-scm.com/download/win
    echo 2. Run the installer with default settings.
    echo 3. Then re-run this script!
    echo.
    pause
    exit /b 1
)

echo [*] Git detected successfully!
echo.
echo Please create a NEW PUBLIC repository on GitHub (e.g. named: prostut-assets)
echo.
set /p REPO_URL="Enter your GitHub repository URL (e.g. https://github.com/YourUsername/prostut-assets.git): "

if "%REPO_URL%"=="" (
    echo [!] No repository URL entered. Exiting.
    pause
    exit /b 1
)

echo.
echo [*] Initializing Git repository...
cd /d "%~dp0"
if not exist ".git" (
    git init
    git branch -M main
)

git remote remove origin 2>nul
git remote add origin %REPO_URL%

echo [*] Staging all images (this may take 1-2 minutes for 18,000 files)...
git add -A

echo [*] Committing files...
git commit -m "Initial commit of Prostut question diagrams and assets"

echo [*] Pushing to GitHub (main branch)...
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo [!] Push failed. Please check your GitHub login / token or repo permissions.
    echo If GitHub asks for authentication, sign in with your GitHub account in browser.
    pause
    exit /b 1
)

echo.
echo ===============================================================
echo [SUCCESS] All images are now live on GitHub!
echo ===============================================================
echo.
echo Now open your .env file on InfinityFree (and local):
echo Add this line (replace with your username and repo name):
echo.
echo IMAGE_CDN_URL=https://cdn.jsdelivr.net/gh/YourUsername/prostut-assets@main
echo.
pause
