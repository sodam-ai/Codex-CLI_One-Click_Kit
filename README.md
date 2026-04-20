# Codex CLI 원클릭 런처 | One-Click Launcher

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![Platform: Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)]()
[![Version: 1.0](https://img.shields.io/badge/Version-1.0-green.svg)]()

> **OpenAI Codex CLI를 더블클릭 한 번으로 설치하고 실행하는 Windows 런처**
>
> A Windows launcher that installs and runs OpenAI Codex CLI with a single double-click.

---

## 목차 | Table of Contents

- [이게 뭔가요?](#이게-뭔가요)
- [필요한 것](#필요한-것)
- [사용 방법 (초보자용)](#사용-방법-초보자용)
- [메뉴 설명](#메뉴-설명)
- [자주 묻는 질문](#자주-묻는-질문)
- [주의사항](#주의사항)
- [English Guide](#english-guide)
- [License](#license)

---

## 이게 뭔가요?

**Codex CLI**는 OpenAI에서 만든 AI 코딩 도구입니다.  
터미널(검은 화면)에서 자연어로 "이 파일을 정리해줘", "Python 코드 만들어줘" 같은 말을 하면 AI가 직접 실행해 주는 도구예요.

이 런처는 그 Codex CLI를 **설치, 실행, 폴더 선택까지 한 번에** 해결해주는 `.bat` 파일입니다.  
코딩을 전혀 몰라도, 더블클릭 하나면 됩니다.

---

## 필요한 것

| 항목 | 설명 | 다운로드 |
|------|------|----------|
| **Windows 10/11** | 이 런처는 Windows 전용입니다 | — |
| **Node.js** | Codex CLI를 실행하기 위한 기반 도구 | [nodejs.org](https://nodejs.org/) → 왼쪽 **LTS** 버튼 클릭 |
| **OpenAI 계정** | ChatGPT Plus, Pro, Business, Edu, Enterprise 플랜 필요 | [platform.openai.com](https://platform.openai.com/) |

> **Node.js가 없으면?** 런처를 실행하면 자동으로 안내해 드립니다. 안내에 따라 설치 후 다시 실행하세요.

---

## 사용 방법 (초보자용)

### 1단계: Node.js 설치

1. [https://nodejs.org/](https://nodejs.org/) 접속
2. 왼쪽 **LTS** 버튼 클릭해서 다운로드
3. 다운로드된 파일 더블클릭 → 계속 Next 누르기
4. 설치 완료

### 2단계: 런처 실행

1. `Codex-CLI_One-Click_Kit.bat` 파일을 찾습니다
2. **더블클릭**합니다
3. "Windows의 PC 보호" 경고가 뜨면 → **추가 정보** → **실행** 클릭

### 3단계: 메뉴에서 선택

```
[0] AUTO START (BEST!)  ← 이걸 누르면 자동으로 알아서 해줍니다
```

처음에는 그냥 **0** 누르고 Enter!

### 4단계: Codex CLI 최초 로그인

처음 실행 시 브라우저가 열리면서 ChatGPT 계정 로그인을 요청합니다.  
로그인하면 바로 사용 가능합니다.

---

## 메뉴 설명

| 번호 | 이름 | 설명 |
|------|------|------|
| **0** | AUTO START | 현재 폴더에 파일이 있으면 자동 시작. 없으면 선택지 제공 |
| **1** | HERE | 런처가 있는 폴더에서 Codex 실행 |
| **2** | DESKTOP | 바탕화면 폴더에서 Codex 실행 |
| **3** | DOCUMENTS | 문서 폴더에서 Codex 실행 |
| **4** | DOWNLOADS | 다운로드 폴더에서 Codex 실행 |
| **5** | NEW PROJECT | 새 프로젝트 폴더를 만들고 Codex 실행 |
| **6** | SELECT FOLDER | 직접 폴더 경로를 선택해서 Codex 실행 |
| **Q** | EXIT | 종료 |

### AUTO 모드 자동 감지 파일

현재 폴더에 아래 파일 중 하나라도 있으면 자동으로 Codex를 시작합니다:

`.html` `.py` `.js` `.ts` `.txt` `.md` `.json` `.xml` `AGENTS.md`

---

## 자주 묻는 질문

**Q: "Windows의 PC 보호" 경고가 떠요**  
A: 정상입니다. "추가 정보" → "실행"을 클릭하세요. 이 파일은 오픈소스이므로 직접 코드를 확인할 수 있습니다.

**Q: Codex CLI가 자동으로 설치되나요?**  
A: 네, 설치가 안 되어 있으면 런처가 설치 여부를 물어보고 자동으로 설치합니다.

**Q: 어떤 ChatGPT 플랜이 필요한가요?**  
A: Plus, Pro, Business, Edu, Enterprise 플랜이 필요합니다. 무료 플랜은 지원되지 않습니다.

**Q: 인터넷이 없으면 안 되나요?**  
A: Codex CLI 자체가 AI 서비스이므로 인터넷 연결이 필요합니다.

**Q: Mac이나 Linux에서도 되나요?**  
A: 이 런처(`.bat`)는 Windows 전용입니다. Mac/Linux는 직접 `npx @openai/codex` 명령어를 터미널에서 실행하세요.

---

## 주의사항

- 이 런처는 **Windows 전용**입니다
- Node.js가 설치되어 있어야 합니다 (런처가 안내해 줍니다)
- OpenAI 유료 플랜이 필요합니다
- Codex CLI 사용 중 생성되는 파일의 책임은 사용자에게 있습니다
- AI가 파일을 수정/삭제할 수 있으므로, 중요한 파일은 미리 백업하세요

---

## 폴더 구조

```
Codex-CLI_One-Click_Kit/
├── Codex-CLI_One-Click_Kit.bat   # 메인 런처 파일 (이것만 실행하면 됨)
├── README.md                     # 이 문서
└── LICENSE                       # 라이선스
```

---

---

## English Guide

### What is this?

**Codex CLI** is an AI coding tool by OpenAI that lets you give natural language instructions in a terminal — like "create a Python script" or "summarize this file" — and the AI executes them directly.

This launcher is a Windows `.bat` file that handles **installation, startup, and folder selection** in one click. No coding knowledge required.

### Requirements

| Item | Description | Download |
|------|-------------|----------|
| **Windows 10/11** | Windows only | — |
| **Node.js** | Runtime for Codex CLI | [nodejs.org](https://nodejs.org/) → Click **LTS** |
| **OpenAI Account** | Plus, Pro, Business, Edu, or Enterprise plan | [platform.openai.com](https://platform.openai.com/) |

### Quick Start

1. Install Node.js from [nodejs.org](https://nodejs.org/) (LTS version)
2. Double-click `Codex-CLI_One-Click_Kit.bat`
3. If Windows SmartScreen appears → click **More info** → **Run anyway**
4. Press **0** for AUTO START
5. Log in with your OpenAI account when prompted

### Menu Options

| Key | Name | Description |
|-----|------|-------------|
| 0 | AUTO START | Auto-detect project files and start |
| 1 | HERE | Run in current folder |
| 2 | DESKTOP | Run from Desktop |
| 3 | DOCUMENTS | Run from Documents folder |
| 4 | DOWNLOADS | Run from Downloads folder |
| 5 | NEW PROJECT | Create new project folder and start |
| 6 | SELECT FOLDER | Choose a custom folder |
| Q | EXIT | Quit |

### Notes

- Windows only (use `npx @openai/codex` on Mac/Linux)
- Requires a paid OpenAI plan (Plus, Pro, Business, Edu, Enterprise)
- AI may modify files — back up important data before use

---

## License

Copyright © 2026 SoDam AI Studio. Released under the [MIT License](./LICENSE).
