@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1

REM ============================================================
REM  Codex CLI 원클릭 런처 v1.0
REM ============================================================

set "SCRIPT_NAME=%~nx0"
set "SCRIPT_DIR=%~dp0"
set "MY_USER=%USERNAME%"
set "MY_HOME=%USERPROFILE%"
set "MY_DESKTOP=%USERPROFILE%\Desktop"
set "MY_DOCS=%USERPROFILE%\Documents"
set "MY_DOWN=%USERPROFILE%\Downloads"

REM === NPM GLOBAL PATH 자동 추가 ===
set "NPM_GLOBAL=%APPDATA%\npm"
if exist "%NPM_GLOBAL%" set "PATH=%NPM_GLOBAL%;%PATH%"

cls
title Codex CLI 원클릭 런처

REM ============================================================
REM  Step 1: 환경 검증
REM ============================================================

echo.
echo [1/3] 시스템 환경 검증 중...
echo.

where node >nul 2>&1
if errorlevel 1 (
    call :ERROR_NODE_NOT_FOUND
    goto :END
)

for /f "tokens=1" %%v in ('node --version') do set "NODE_VER=%%v"
set "NODE_VER=!NODE_VER:v=!"
echo    ✓ Node.js !NODE_VER! 감지 완료

where npm >nul 2>&1
if errorlevel 1 (
    call :ERROR_NPM_NOT_FOUND
    goto :END
)

echo    ✓ NPM 정상 작동
echo.

REM ============================================================
REM  Step 2: Codex CLI 설치 상태 확인
REM ============================================================

echo [2/3] Codex CLI 상태 확인 중...
echo.

where codex >nul 2>&1
if errorlevel 1 (
    call :INSTALL_CODEX
    if errorlevel 1 goto :END
) else (
    echo    ✓ Codex CLI 이미 설치됨
)

for /f "delims=" %%v in ('codex --version 2^>nul') do set "CODEX_VER=%%v"
if defined CODEX_VER (
    echo    ✓ 버전: !CODEX_VER!
) else (
    echo    ! 버전 확인 실패
)

echo.

REM ============================================================
REM  Step 3: 메뉴
REM ============================================================

:MENU
cls
echo.
echo ============================================
echo         CODEX CLI - UNIVERSAL
echo ============================================
echo.
echo   PC User: %MY_USER%
echo   Home: %MY_HOME%
echo.
echo ============================================
echo.
echo   [0] = AUTO START (BEST!)
echo.
echo   [1] = HERE
echo   [2] = DESKTOP
echo   [3] = DOCUMENTS  
echo   [4] = DOWNLOADS
echo.
echo   [5] = NEW PROJECT
echo   [6] = SELECT FOLDER
echo.
echo   [Q] = EXIT
echo.
echo ============================================
echo.
echo   TIP: JUST PRESS 0
echo.
set "choice="
set /p "choice=SELECT: "

if "%choice%"=="0" goto AUTO
if "%choice%"=="1" goto HERE
if "%choice%"=="2" goto DESKTOP
if "%choice%"=="3" goto DOCUMENTS
if "%choice%"=="4" goto DOWNLOADS
if "%choice%"=="5" goto NEW
if "%choice%"=="6" goto SELECT
if /i "%choice%"=="Q" exit

echo Try again!
timeout /t 2 >nul
goto MENU

:AUTO
cls
echo ============================================
echo              AUTO MODE
echo ============================================
echo.
echo Checking: %CD%
echo.

REM Check if project folder
if exist "*.html" goto RUN
if exist "*.py" goto RUN
if exist "*.js" goto RUN
if exist "*.ts" goto RUN
if exist "*.txt" goto RUN
if exist "*.md" goto RUN
if exist "*.json" goto RUN
if exist "*.xml" goto RUN
if exist "AGENTS.md" goto RUN

echo No project files found
echo.
echo [1] Start here anyway
echo [2] Go to Desktop
echo [3] Create new project
echo.
set "auto="
set /p "auto=Choose (1-3): "

if "%auto%"=="1" goto RUN
if "%auto%"=="2" goto DESKTOP
if "%auto%"=="3" goto NEW
goto RUN

:RUN
echo.
echo --------------------------------------------
echo Starting Codex CLI...
echo Path: %CD%
echo --------------------------------------------
echo.
echo    💡 첫 실행 시 ChatGPT 계정 로그인 필요
echo    💡 Plus, Pro, Business, Edu, Enterprise 플랜 지원
echo.
codex
if errorlevel 1 (
    echo.
    echo ERROR: Codex CLI 실행 실패!
    echo.
)
pause
goto MENU

:HERE
cls
echo ============================================
echo           CURRENT FOLDER
echo ============================================
echo.
echo Path: %CD%
echo.
codex
pause
goto MENU

:DESKTOP
cls
if not exist "%MY_DESKTOP%" mkdir "%MY_DESKTOP%" 2>nul
cd /d "%MY_DESKTOP%"
echo ============================================
echo              DESKTOP
echo ============================================
echo.
echo Path: %MY_DESKTOP%
echo.
codex
pause
goto MENU

:DOCUMENTS
cls
if not exist "%MY_DOCS%" mkdir "%MY_DOCS%" 2>nul
cd /d "%MY_DOCS%"
echo ============================================
echo            DOCUMENTS
echo ============================================
echo.
echo Path: %MY_DOCS%
echo.
codex
pause
goto MENU

:DOWNLOADS
cls
if not exist "%MY_DOWN%" mkdir "%MY_DOWN%" 2>nul
cd /d "%MY_DOWN%"
echo ============================================
echo            DOWNLOADS
echo ============================================
echo.
echo Path: %MY_DOWN%
echo.
codex
pause
goto MENU

:NEW
cls
echo ============================================
echo          NEW PROJECT
echo ============================================
echo.
echo Where to create?
echo.
echo [1] Desktop
echo [2] Documents
echo [3] Current folder
echo [4] Custom path
echo.
set "where="
set /p "where=Select (1-4): "

if "%where%"=="1" (
    set "create_path=%MY_DESKTOP%"
    set "create_name=Desktop"
)
if "%where%"=="2" (
    set "create_path=%MY_DOCS%"
    set "create_name=Documents"
)
if "%where%"=="3" (
    set "create_path=%CD%"
    set "create_name=Current"
)
if "%where%"=="4" (
    echo.
    set /p "create_path=Enter full path: "
    set "create_name=Custom"
)

echo.
set "project="
set /p "project=Project name: "
if "%project%"=="" goto MENU

cd /d "%create_path%" 2>nul
if errorlevel 1 (
    echo ERROR: Invalid path
    pause
    goto MENU
)

mkdir "%project%" 2>nul
cd "%project%"
echo.
echo SUCCESS!
echo Created: %create_path%\%project%
echo.
codex
pause
goto MENU

:SELECT
cls
echo ============================================
echo          SELECT FOLDER
echo ============================================
echo.
echo Quick paths:
echo [1] %MY_DESKTOP%
echo [2] %MY_DOCS%
echo [3] %MY_DOWN%
echo [4] %MY_HOME%
echo [5] C:\
echo [6] Type custom path
echo.
set "sel="
set /p "sel=Select (1-6): "

if "%sel%"=="1" cd /d "%MY_DESKTOP%"
if "%sel%"=="2" cd /d "%MY_DOCS%"
if "%sel%"=="3" cd /d "%MY_DOWN%"
if "%sel%"=="4" cd /d "%MY_HOME%"
if "%sel%"=="5" cd /d "C:\"
if "%sel%"=="6" (
    echo.
    set /p "custom=Enter path: "
    cd /d "!custom!" 2>nul
    if errorlevel 1 (
        echo ERROR: Path not found
        pause
        goto MENU
    )
)

echo.
echo Moved to: %CD%
echo.
codex
pause
goto MENU

REM ============================================================
REM  함수: Codex CLI 자동 설치
REM ============================================================
:INSTALL_CODEX
echo    ! Codex CLI가 설치되지 않았습니다.
echo.
echo    자동으로 설치하시겠습니까?
echo.

set "INSTALL="
set /p "INSTALL=선택 (y/n): "

if /i not "!INSTALL!"=="y" (
    echo.
    echo    설치를 취소했습니다.
    timeout /t 2 >nul
    exit /b 1
)

echo.
echo    📦 Codex CLI 설치 중... (1-2분 소요)
echo.

call npm install -g @openai/codex

if errorlevel 1 (
    echo.
    echo    ❌ 설치 실패! 다음을 확인해주세요:
    echo       1. 인터넷 연결 상태
    echo       2. NPM 설정
    echo.
    echo    💡 수동 설치: npm install -g @openai/codex
    echo.
    pause
    exit /b 1
)

echo.
echo    ✓ 설치 완료!
echo.
timeout /t 2 >nul
exit /b 0

REM ============================================================
REM  에러 처리 함수들
REM ============================================================

:ERROR_NODE_NOT_FOUND
cls
echo.
echo    ╔════════════════════════════════════════════════╗
echo    ║             ⚠️  Node.js 미설치                 ║
echo    ╚════════════════════════════════════════════════╝
echo.
echo    Codex CLI를 사용하려면 Node.js가 필요합니다.
echo.
echo    📥 다운로드: https://nodejs.org/
echo       → 왼쪽 LTS 버전 설치
echo.
echo    설치 후 이 파일을 다시 실행해주세요.
echo.
pause
exit /b 1

:ERROR_NPM_NOT_FOUND
echo.
echo    ❌ NPM을 찾을 수 없습니다.
echo.
echo    Node.js를 재설치하거나 환경변수(PATH)를 확인하세요.
echo.
pause
exit /b 1

REM ============================================================
REM  종료
REM ============================================================
:END
endlocal
exit /b 0