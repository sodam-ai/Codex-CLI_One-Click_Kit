@echo off
setlocal EnableDelayedExpansion
chcp 949 >nul 2>&1

REM ============================================================
REM  Codex CLI 원클릭 키트 v3.4  (Korean / CP949)
REM  - 설치 / 실행 / 업데이트 / 제거 / 진단 / 사용법
REM  - v3.4: 선택 안전화(공백제거·친절안내·제거 맨끝 분리·되돌리기 안내),
REM          시작 버튼 박스, Enter 바로 시작, 기본=파일수정
REM ============================================================

set "SCRIPT_DIR=%~dp0"
set "MY_USER=%USERNAME%"
set "MY_HOME=%USERPROFILE%"
set "MY_DESKTOP=%USERPROFILE%\Desktop"
set "MY_DOCS=%USERPROFILE%\Documents"
set "MY_DOWN=%USERPROFILE%\Downloads"
set "CODEX_HOME=%USERPROFILE%\.codex"
set "KITDATA=%LOCALAPPDATA%\codex-cli-one-click-kit"

REM === npm 전역 설치 경로를 PATH 에 추가 (codex 명령 인식용) ===
set "NPM_GLOBAL=%APPDATA%\npm"
if exist "%NPM_GLOBAL%" set "PATH=%NPM_GLOBAL%;%PATH%"

title Codex CLI 원클릭 키트
cls

REM ============================================================
REM  시작: 컴퓨터 환경 점검
REM ============================================================
:BOOT
echo.
echo  [1/2] 컴퓨터 환경을 확인합니다...
echo.

where node >nul 2>&1
if errorlevel 1 (
    call :NEED_NODE
    goto END
)
for /f "tokens=1" %%v in ('node --version') do set "NODE_VER=%%v"
echo     [OK] Node.js !NODE_VER! 확인

where npm >nul 2>&1
if errorlevel 1 (
    call :NEED_NPM
    goto END
)
echo     [OK] npm 확인
echo.

echo  [2/2] Codex CLI 설치 확인...
echo.
call :CHECK_CODEX
echo.
timeout /t 1 >nul
if not exist "%KITDATA%\welcomed.txt" call :FIRSTRUN
goto MENU

REM ============================================================
REM  메인 메뉴 (평평한 번호 선택)
REM ============================================================
:MENU
call :READ_MODE
call :GET_LASTDIR
cls
echo ============================================
echo            Codex 한 번에 켜기  ^(원클릭 키트^)
echo ============================================
if defined CODEX_OK (
    echo   상태 : 설치됨   !CODEX_VER!
) else (
    echo   상태 : 아직 설치 안 됨
)
if "!RUNMODE!"=="write" (
    echo   모드 : 이 폴더 안에서 파일도 만들 수 있음
) else (
    echo   모드 : 읽기 전용  ^(AI가 파일을 안 건드림^)
)
echo   폴더 : !LAUNCHDIR!
echo ============================================
echo.
echo     /==================================\
echo     ^|      ^>^>^>   [  ENTER  ]   ^<^<^<      ^|
echo     \==================================/
echo      엔터^(Enter^) 키 한 번이면 바로 시작!
echo.
echo     [1] 코덱스 시작
echo     [2] 다른 폴더에서 시작
echo     [3] 설치 / 다시 설치
echo     [4] 업데이트 ^(최신 버전으로^)
echo     [5] 모드 바꾸기 ^(파일수정 ^<-^> 읽기전용^)
echo     [6] 안 될 때 ^(자동 진단^)
echo     [H] 사용법       [Q] 끄기
echo   ----- 조심해서 쓰는 메뉴 -----
echo     [7] 제거 ^(Codex 지우기^)
echo ============================================
echo.
set "choice="
set /p "choice=번호 입력 후 Enter (그냥 Enter = 시작) : "
if not defined choice goto START_HERE
set "choice=!choice: =!"
if not defined choice goto START_HERE
if "!choice!"=="1" goto START_HERE
if "!choice!"=="2" goto OPENFOLDER
if "!choice!"=="3" goto SETUP
if "!choice!"=="4" goto UPDATE
if "!choice!"=="5" goto CHGMODE
if "!choice!"=="6" goto DIAGNOSE
if "!choice!"=="7" goto UNINSTALL
if /i "!choice!"=="H" goto HELP
if /i "!choice!"=="Q" goto END

echo.
echo   [안내] 화면의 번호 1~7, 또는 H, Q 중에서 입력해 주세요.
timeout /t 2 >nul
goto MENU

REM ============================================================
REM  [1 / Enter] 바로 시작 - 저장된 모드로 질문 없이 켜기
REM ============================================================
:START_HERE
call :ENSURE
if errorlevel 1 goto MENU
call :GET_LASTDIR
cd /d "!LAUNCHDIR!" 2>nul
call :SAVE_LASTDIR "!CD!"
cls
echo   폴더 : !CD!
call :START_CODEX
pause
goto MENU

REM ============================================================
REM  [2] 다른 폴더에서 시작 (작업 폴더 선택)
REM ============================================================
:OPENFOLDER
call :ENSURE
if errorlevel 1 goto MENU
cls
echo ============================================
echo              다른 폴더에서 시작
echo ============================================
echo.
echo   어느 폴더에서 Codex 를 켤까요?
echo.
echo     [1] 지금 이 폴더            ^(%CD%^)
echo     [2] 바탕화면
echo     [3] 문서 폴더
echo     [4] 다운로드 폴더
echo     [5] 새 폴더 만들기
echo     [6] 폴더 경로 붙여넣기  ^(직접 입력^)
echo     [B] 뒤로
echo.
set "sel="
set /p "sel=선택 (1-6, 뒤로=B): "
if /i "!sel!"=="B" goto MENU
set "TARGET="
if "!sel!"=="1" set "TARGET=%CD%"
if "!sel!"=="2" set "TARGET=%MY_DESKTOP%"
if "!sel!"=="3" set "TARGET=%MY_DOCS%"
if "!sel!"=="4" set "TARGET=%MY_DOWN%"
if "!sel!"=="5" goto OF_NEW
if "!sel!"=="6" goto OF_CUSTOM
if not defined TARGET goto MENU
goto OF_GO

:OF_NEW
echo.
echo   새 폴더를 어디에 만들까요?
echo     [1] 바탕화면    [2] 문서    [3] 지금 이 폴더
echo.
set "where="
set /p "where=선택 (1-3): "
set "base="
if "!where!"=="1" set "base=%MY_DESKTOP%"
if "!where!"=="2" set "base=%MY_DOCS%"
if "!where!"=="3" set "base=%CD%"
if not defined base goto MENU
echo.
set "pname="
set /p "pname=새 폴더 이름 : "
if "!pname!"=="" goto MENU
if not exist "!base!" mkdir "!base!" 2>nul
cd /d "!base!" 2>nul
if errorlevel 1 (
    echo   [X] 경로를 찾을 수 없습니다.
    pause
    goto MENU
)
mkdir "!pname!" 2>nul
cd "!pname!"
set "TARGET=!CD!"
goto OF_GO

:OF_CUSTOM
echo.
set "custom="
set /p "custom=전체 경로 붙여넣기 : "
if "!custom!"=="" goto MENU
cd /d "!custom!" 2>nul
if errorlevel 1 (
    echo   [X] 경로를 찾을 수 없습니다.
    pause
    goto MENU
)
set "TARGET=!CD!"
goto OF_GO

:OF_GO
cd /d "!TARGET!" 2>nul
if errorlevel 1 (
    echo   [X] 경로를 찾을 수 없습니다.
    pause
    goto MENU
)
call :SAVE_LASTDIR "!CD!"
call :READ_MODE
set "WARNP="
if /i "!CD!"=="%MY_DESKTOP%" set "WARNP=1"
if /i "!CD!"=="%MY_DOCS%" set "WARNP=1"
if /i "!CD!"=="%MY_DOWN%" set "WARNP=1"
if /i "!CD!"=="%MY_HOME%" set "WARNP=1"
if defined WARNP if "!RUNMODE!"=="write" (
    echo.
    echo   [주의] 여기는 개인 폴더예요. 파일수정 모드라서
    echo          AI가 이 폴더 안의 파일을 고칠 수 있어요.
    echo.
    set "WP="
    set /p "WP=계속할까요? (Enter=예, N=아니오): "
    if /i "!WP!"=="N" goto MENU
)
cls
echo   폴더 : !CD!
call :START_CODEX
pause
goto MENU

REM ============================================================
REM  [5] 모드 바꾸기
REM ============================================================
:CHGMODE
cls
echo ============================================
echo               모드 바꾸기
echo ============================================
call :ASK_MODE
echo.
echo   [OK] 정했습니다. 다음 시작부터 적용됩니다.
pause
goto MENU

REM ============================================================
REM  [3] 설치 / 다시 설치
REM ============================================================
:SETUP
cls
echo ============================================
echo              설치 / 다시 설치
echo ============================================
call :INSTALL_CODEX
call :CHECK_CODEX >nul
echo.
pause
goto MENU

REM ============================================================
REM  [4] 업데이트
REM ============================================================
:UPDATE
cls
echo ============================================
echo            최신 버전으로 업데이트
echo ============================================
echo   명령 : npm install -g @openai/codex@latest
echo.
call npm install -g @openai/codex@latest
if errorlevel 1 (
    echo.
    echo   [X] 업데이트 실패. 인터넷 연결을 확인하세요.
) else (
    echo.
    echo   [OK] 업데이트 완료!
)
call :CHECK_CODEX >nul
echo.
pause
goto MENU

REM ============================================================
REM  [7] 제거
REM ============================================================
:UNINSTALL
cls
echo ============================================
echo                제거 ^(지우기^)
echo ============================================
echo.
echo   Codex CLI 를 컴퓨터에서 지웁니다.
echo   ^(되돌리려면 나중에 메뉴 [3] 설치로 다시 깔 수 있어요^)
echo   명령 : npm uninstall -g @openai/codex
echo.
set "DEL="
set /p "DEL=정말 제거할까요? (y/n): "
if /i not "!DEL!"=="y" (
    echo   제거를 취소했습니다.
    timeout /t 2 >nul
    goto MENU
)
echo.
echo   제거 중...
call npm uninstall -g @openai/codex
echo.
echo   [OK] 프로그램 제거를 시도했습니다.
echo.
echo   로그인 정보도 함께 지울까요?
echo     위치 : %CODEX_HOME%
echo     * 지우면 다음에 다시 로그인해야 합니다. 모르면 n 을 권장합니다.
echo.
set "DELCFG="
set /p "DELCFG=설정까지 지울까요? (y/n): "
if /i "!DELCFG!"=="y" (
    if exist "%CODEX_HOME%" (
        rmdir /s /q "%CODEX_HOME%"
        echo   [OK] 설정 폴더를 지웠습니다.
    ) else (
        echo   설정 폴더가 없습니다.
    )
) else (
    echo   설정은 그대로 두었습니다.
)
call :CHECK_CODEX >nul
echo.
pause
goto MENU

REM ============================================================
REM  [6] 안 될 때 (자동 진단)
REM ============================================================
:DIAGNOSE
cls
set "DIAGFILE=%SCRIPT_DIR%진단결과.txt"
call :DIAG_BODY > "%DIAGFILE%" 2>&1
type "%DIAGFILE%"
echo.
echo ============================================
echo   진단 결과를 파일로 저장했습니다:
echo   %DIAGFILE%
echo   해결이 안 되면 위 내용을 그대로(또는 화면을 캡처해)
echo   AI(클로드/챗봇)에게 붙여넣으면 원인 찾기가 쉽습니다.
echo ============================================
pause
goto MENU

REM ============================================================
REM  [H] 사용법 / 명령어
REM ============================================================
:HELP
cls
echo ============================================
echo           사용법 / 자주 쓰는 명령어
echo ============================================
echo.
echo  [이 키트 메뉴 뜻]
echo    [1] 시작     : 저장된 폴더에서 바로 Codex 시작
echo    [2] 다른폴더 : 바탕화면/문서/새폴더 등에서 시작
echo    [3] 설치     : Codex 처음 설치 또는 다시 설치
echo    [4] 업데이트 : 최신 버전으로 올리기
echo    [5] 모드     : 파일수정 ^<-^> 읽기전용 바꾸기
echo    [6] 진단     : 안 될 때 원인 자동 점검
echo    [7] 제거     : Codex 지우기 ^([3]으로 되돌리기 가능^)
echo.
echo  [기본 사용]
echo    codex                  대화창처럼 시작 ^(질문 가능^)
echo    codex "할 일 설명"      바로 작업 시키기
echo                           예: codex "이 코드 설명해줘"
echo    codex exec "작업"       대화 없이 한 번에 실행
echo.
echo  [관리]
echo    codex --version        버전 확인
echo    codex logout           로그아웃
echo.
echo  [모드 직접 지정]
echo    codex --sandbox read-only         읽기만 ^(파일 안 건드림^)
echo    codex --sandbox workspace-write   이 폴더 안에서만 파일 수정
echo.
echo  [대화 중] /help  을 입력하면 더 많은 기능을 볼 수 있습니다.
echo  [끝낼 때] /quit  입력, 또는 Ctrl 키와 C 를 함께 누르세요.
echo ============================================
pause
goto MENU

REM ============================================================
REM  내부 함수
REM ============================================================
:CHECK_CODEX
set "CODEX_OK="
set "CODEX_VER="
where codex >nul 2>&1
if errorlevel 1 (
    echo     [!] Codex CLI 가 아직 설치되지 않았습니다. ^(메뉴 3 또는 1^)
    exit /b 0
)
set "CODEX_OK=1"
for /f "delims=" %%v in ('codex --version 2^>nul') do set "CODEX_VER=%%v"
if defined CODEX_VER (
    echo     [OK] Codex CLI 설치됨   !CODEX_VER!
) else (
    echo     [OK] Codex CLI 설치됨
)
exit /b 0

:ENSURE
if defined CODEX_OK exit /b 0
echo.
echo   [!] Codex 가 설치되어 있지 않아 먼저 설치합니다.
echo.
call :INSTALL_CODEX
if errorlevel 1 exit /b 1
call :CHECK_CODEX >nul
if defined CODEX_OK (exit /b 0) else (exit /b 1)

:INSTALL_CODEX
where codex >nul 2>&1
if not errorlevel 1 (
    echo   이미 설치되어 있습니다. 다시 설치하려면 계속 진행하세요.
    echo.
)
echo   Codex CLI 설치 명령 : npm install -g @openai/codex
echo   ^(보통 1~2분 걸립니다^)
echo.
set "INSTALL="
set /p "INSTALL=설치를 진행할까요? (y/n): "
if /i not "!INSTALL!"=="y" (
    echo   설치를 건너뜁니다.
    timeout /t 2 >nul
    exit /b 1
)
echo.
echo   설치 중... 잠시만 기다려 주세요.
echo.
call npm install -g @openai/codex
if errorlevel 1 (
    echo.
    echo   [X] 설치에 실패했습니다. 아래를 확인하세요:
    echo       1. 인터넷 연결 상태
    echo       2. 잠시 후 다시 시도
    echo   직접 설치 명령 : npm install -g @openai/codex
    echo.
    pause
    exit /b 1
)
if exist "%NPM_GLOBAL%" set "PATH=%NPM_GLOBAL%;%PATH%"
echo.
echo   [OK] 설치 완료!
timeout /t 2 >nul
exit /b 0

:START_CODEX
call :READ_MODE
call :LOGIN_TIP
echo.
echo   ---------- 이렇게 시켜보세요 ^(한국어로 입력^) ----------
echo     이 폴더에 어떤 파일이 있는지 설명해줘
echo     이 코드가 무슨 일을 하는지 쉽게 알려줘
echo     간단한 메모장 프로그램 만들어줘
echo   ------------------------------------------------------
echo   * 끝낼 때는 /quit 입력, 또는 Ctrl 키와 C 를 함께 누르세요.
echo.
if "!RUNMODE!"=="write" (
    echo   [파일수정 모드] 이 폴더 안에서 AI가 파일을 만들고 고칠 수 있어요.
    echo.
    codex --sandbox workspace-write
) else (
    echo   [읽기 전용] 읽기만 합니다. 파일은 만들지 않습니다.
    echo.
    codex --sandbox read-only
)
exit /b 0

:READ_MODE
set "RUNMODE="
if exist "%KITDATA%\mode.txt" set /p RUNMODE=<"%KITDATA%\mode.txt"
if "!RUNMODE!"=="read" exit /b 0
if "!RUNMODE!"=="write" exit /b 0
set "RUNMODE=write"
exit /b 0

:ASK_MODE
echo.
echo   Codex 가 무엇을 할 수 있게 할까요?
echo     [1] 이 폴더 안에서 파일도 만들기   ^<- 추천 ^(그냥 Enter^)
echo     [2] 안전하게 읽기만 ^(읽기 전용^)
echo.
set "M="
set /p "M=선택 (1-2, 그냥 Enter=1): "
if "!M!"=="2" (set "RUNMODE=read") else (set "RUNMODE=write")
if not exist "%KITDATA%" mkdir "%KITDATA%" 2>nul
(echo !RUNMODE!)>"%KITDATA%\mode.txt"
exit /b 0

:GET_LASTDIR
set "LAUNCHDIR=%CD%"
if exist "%KITDATA%\lastdir.txt" set /p LAUNCHDIR=<"%KITDATA%\lastdir.txt"
if not exist "!LAUNCHDIR!" set "LAUNCHDIR=%CD%"
exit /b 0

:SAVE_LASTDIR
if not exist "%KITDATA%" mkdir "%KITDATA%" 2>nul
(echo %~1)>"%KITDATA%\lastdir.txt"
exit /b 0

:LOGIN_TIP
if not exist "%CODEX_HOME%\auth.json" (
    echo.
    echo   [안내] 첫 실행이면 브라우저로 ChatGPT 로그인이 필요합니다.
    echo          Plus ~ Enterprise 플랜으로 사용할 수 있고,
    echo          보안을 위해 2단계 인증 MFA 사용을 권장합니다.
    echo          OpenAI API 키로도 사용할 수 있습니다.
)
exit /b 0

:FIRSTRUN
cls
echo ============================================
echo    Codex CLI 원클릭 키트에 오신 걸 환영합니다
echo ============================================
echo.
echo   이 프로그램은 OpenAI 의 AI 코더 Codex 를
echo   클릭 한 번으로 바로 켤 수 있게 해줍니다.
echo.
echo   기본은 "이 폴더 안에서 파일도 만들 수 있음" 입니다.
echo   ^(메모장/코드 만들기가 바로 됩니다. 이 폴더 밖과 PC 전체는 안전^)
echo.
echo   * 파란 "PC 보호" 경고창이 뜨면 추가 정보 -^> 실행 을 누르세요.
echo   * 명령은 한국어로 시키면 됩니다.
echo.
set "FM="
set /p "FM=그냥 Enter = 시작 / 안전하게 읽기만 원하면 R : "
if /i "!FM!"=="R" (set "RUNMODE=read") else (set "RUNMODE=write")
if not exist "%KITDATA%" mkdir "%KITDATA%" 2>nul
(echo !RUNMODE!)>"%KITDATA%\mode.txt"
(echo shown)>"%KITDATA%\welcomed.txt"
echo.
echo   준비 끝! 이제 Codex 를 켭니다.
echo   ^(다음부터는 메뉴에서 Enter 만 누르면 됩니다^)
echo.
pause
call :ENSURE
if errorlevel 1 exit /b 0
call :SAVE_LASTDIR "%CD%"
cls
echo   폴더 : %CD%
call :START_CODEX
pause
exit /b 0

:DIAG_BODY
echo ===== Codex CLI 키트 진단 결과 =====
echo.
echo [Node.js]
where node >nul 2>&1 && node --version || echo     설치 안 됨 - https://nodejs.org 에서 LTS 설치
echo.
echo [npm]
where npm >nul 2>&1 && npm --version || echo     없음
echo.
echo [Codex CLI]
where codex >nul 2>&1 && codex --version || echo     설치 안 됨 - 메뉴 3번에서 설치
echo.
echo [npm 전역 경로]
if exist "%NPM_GLOBAL%" (echo     있음: %NPM_GLOBAL%) else (echo     없음 - 설치 후 컴퓨터 재시작 권장)
echo.
echo [로그인 상태]
if exist "%CODEX_HOME%\auth.json" (echo     로그인 정보 있음) else (echo     아직 로그인 안 됨)
echo.
echo [실행 모드 설정]
if exist "%KITDATA%\mode.txt" (type "%KITDATA%\mode.txt") else (echo     아직 설정 안 됨 - 기본 파일수정)
echo.
echo [마지막 폴더 기억]
if exist "%KITDATA%\lastdir.txt" (type "%KITDATA%\lastdir.txt") else (echo     기록 없음 - 현재 폴더 사용)
echo.
echo [인터넷 연결]
ping -n 1 api.openai.com >nul 2>&1 && echo     연결됨 || echo     확인 필요
echo.
echo ===================================
exit /b 0

REM ============================================================
REM  설치 안내
REM ============================================================
:NEED_NODE
cls
echo ============================================
echo            Node.js 가 필요합니다
echo ============================================
echo.
echo   Codex CLI 를 켜려면 Node.js 가 깔려 있어야 합니다.
echo.
where winget >nul 2>&1
if not errorlevel 1 (
    echo   이 컴퓨터는 자동 설치를 시도할 수 있습니다.
    set "WG="
    set /p "WG=자동으로 Node.js 를 설치할까요? (y/n): "
    if /i "!WG!"=="y" (
        echo.
        echo   설치 중... 권한 창이 뜨면 허용해 주세요.
        winget install -e --id OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
        echo.
        echo   설치가 끝나면 이 창을 닫았다가 다시 열어 주세요.
        echo   ^(PATH 적용을 위해 재시작 필요^)
        echo.
        pause
        exit /b 1
    )
)
echo   직접 설치 : https://nodejs.org/   ^(왼쪽 LTS 권장^)
echo   설치 후 이 파일을 다시 실행하세요.
echo.
pause
exit /b 1

:NEED_NPM
echo.
echo   [X] npm 을 찾을 수 없습니다.
echo   Node.js 를 다시 설치하거나 PATH 설정을 확인하세요.
echo.
pause
exit /b 1

REM ============================================================
REM  종료
REM ============================================================
:END
endlocal
exit /b 0
