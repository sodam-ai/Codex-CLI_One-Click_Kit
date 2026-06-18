# Codex CLI One-Click Kit

> A Korean-friendly helper that lets even first-time computer/AI users **install, run, and remove** OpenAI's **Codex CLI** (an AI coding assistant) by **double-clicking a single file**.

**한국어 README:** [`README.md`](./README.md) · **Beginner Guide:** [`Beginner_Guide_EN.md`](./Beginner_Guide_EN.md)

---

## 0. 30-Second Quick Start

1. **Double-click** `Codex-CLI_One-Click_Kit.bat`.
2. When the menu appears, just press **`Enter`** once. (= Start Codex)
3. On first run, **log in to ChatGPT** in the browser. Done — now type **what you want, in plain language**, into the black window.
   - Example: `Explain what files are in this folder`
   - To quit: type `/quit`, or press `Ctrl` + `C`

> For a step-by-step walkthrough, see the [Beginner Guide](./Beginner_Guide_EN.md).

---

## 1. What Is This?

- **Codex CLI**: OpenAI's AI tool that does things like "explain this code" or "make a simple notepad app" **when you ask in plain language**, right inside a folder on your PC.
- **This kit**: A **menu program** that makes installing and using that tool easy.
  - It is an **unofficial helper**, not the official program. It does **not** bundle Codex; it only helps **install it from the official source (npm)**.

## 2. Prerequisites / Required Software

| Item | Required? | Notes |
|---|---|---|
| **Windows** PC | Required | Works on Windows 10/11. |
| **Node.js** (free) | Required | Needed to run Codex. If missing, the kit tells you and tries to **auto-install** it when possible. Manual download: <https://nodejs.org/> → the **LTS** version on the left. |
| **ChatGPT account** | Required (one of) | Log in to use. A free account works; for heavier use, Plus or higher is recommended. |
| or **OpenAI API key** | Optional | You can use an API key instead of an account (billed per usage). |
| Internet connection | Required | Needed for install, login, and AI responses. |

> **Cost note:** Using Codex consumes your OpenAI ChatGPT plan or API usage. Free accounts have small limits. Check OpenAI's official pricing for details.

## 3. Download & Install

1. Place this kit folder (the folder with these files) wherever you like on your PC.
   - **Important:** Keep the files (`.bat`, guides) **together in one folder**. Moving them apart can break the on-screen help.
2. Double-click `Codex-CLI_One-Click_Kit.bat`.
3. If Codex is missing, the kit **guides you through installation automatically**. Just press `y` → Enter.
   - Internally it runs the official command `npm install -g @openai/codex`. This usually takes 1–2 minutes.

> If a blue **"Windows protected your PC"** warning appears, that's normal (it shows for new files). Click **`More info`** → **`Run anyway`**.

## 4. How to Run

- **Double-click** `Codex-CLI_One-Click_Kit.bat` → a black window shows a Korean menu.
- Press **`Enter`** (or `1`) to start Codex immediately.

## 5. Menu at a Glance (current version)

```
    /==================================\
    |      >>>   [  ENTER  ]   <<<      |
    \==================================/
     Press Enter once to start right away!

    [1] Start Codex
    [2] Start in another folder
    [3] Install / Reinstall
    [4] Update (to latest)
    [5] Change mode (edit files <-> read-only)
    [6] When it doesn't work (auto-diagnose)
    [H] Help          [Q] Quit
  ----- use with care -----
    [7] Remove (uninstall Codex)
```

| Key | Action | Description |
|---|---|---|
| **Enter** or **1** | Start Codex | Start immediately in the remembered folder (most used) |
| **2** | Start in another folder | Pick Desktop, Documents, Downloads, a new folder, or type a path |
| **3** | Install / Reinstall | Install Codex for the first time, or reinstall |
| **4** | Update | Upgrade to the latest version |
| **5** | Change mode | Toggle "edit files" ↔ "read-only" (remembered once set) |
| **6** | When it doesn't work | Auto-diagnose (also saved to `진단결과.txt`) |
| **7** | Remove | Uninstall Codex (reversible via `3` Install) |
| **H** | Help | View commands / help |
| **Q** | Quit | Exit the menu |

> Input is **key + Enter**. Leading/trailing spaces are ignored, and a wrong key just re-shows the prompt — so it's safe.

## 6. How to Use / How It Works

1. Press **Enter** in the menu → Codex starts.
2. In the black window, type **what you want in plain language** and press Enter.
   - `Explain what files are in this folder`
   - `Explain in simple terms what this code does`
   - `Make a simple notepad program`
3. To quit: type `/quit`, or press `Ctrl` + `C`.

### Mode (Safety) — Important

| Mode | Meaning | When |
|---|---|---|
| **Edit files** (default) | AI can create/modify files **only inside the current folder** (never the rest of your PC) | When you want real output, e.g. "make a notepad app" |
| **Read-only** | AI **never touches files** (reads only) | When you only want explanations, or want to be more conservative |

- Change the mode anytime in menu **`5`**; once set, it's remembered.
- If you start in a **personal folder (Desktop, Documents, etc.) with "Edit files"**, the kit asks for confirmation once.

## 7. Workflow (Overall Flow)

```
[Double-click] → [Korean menu] → [Enter = Start]
     → (first time only) log in to ChatGPT
     → choose a working folder (default: remembered folder, or [2] for another)
     → ask in plain language  →  AI answers or creates files
     → quit with /quit  →  back to the menu
```

## 8. File / Document Locations

| Item | Location |
|---|---|
| Executable | `Codex-CLI_One-Click_Kit.bat` (this folder) |
| Korean README | `README.md` · English `README.en.md` |
| Beginner guide | `왕초보_시작_가이드.md` (Korean) · `Beginner_Guide_EN.md` (English) |
| Errors & commands cheat sheet | `오류대처_명령어_치트시트.md` |
| License | `LICENSE` (Apache-2.0) |
| PDF documents | `*.pdf` of the docs above (same folder) |
| **Kit settings** | `C:\Users\(you)\AppData\Local\codex-cli-one-click-kit\` (remembers mode & last folder) |
| **Codex login info** | `C:\Users\(you)\.codex\` (asked separately on removal) |
| Diagnosis result | `진단결과.txt` (this folder, created by menu `6`) |

## 9. Common Commands

> The menu is usually enough. Below is for typing directly in the black window (terminal).

| Command | Meaning |
|---|---|
| `codex` | Start interactively |
| `codex "task description"` | Run a task directly (e.g. `codex "explain this code"`) |
| `codex exec "task"` | Run once without conversation |
| `codex --version` | Show installed version |
| `codex logout` | Log out |
| `codex --sandbox read-only` | Read-only (won't touch files) |
| `codex --sandbox workspace-write` | Edit files only inside the current folder |
| `npm install -g @openai/codex@latest` | Update to latest (same as menu `4`) |
| `npm uninstall -g @openai/codex` | Remove (same as menu `7`) |

## 10. Troubleshooting (Summary)

| Symptom | Fix |
|---|---|
| `codex` command not found | **Restart** the PC, then run again. If it persists, menu `6` (diagnose) |
| Install failed | Check internet, then reinstall via menu `3` |
| Login page won't open | Check internet/firewall. Paste the on-screen URL into a browser manually |
| `429 / Too many requests` | Usage limit reached. Wait the shown time, then retry |
| Node version too old | Reinstall the latest **LTS** (22+) from <https://nodejs.org> |

> For a fuller table, see the [errors & commands cheat sheet](./오류대처_명령어_치트시트.md) or the [Beginner Guide](./Beginner_Guide_EN.md). When stuck, capture the menu **`6` diagnose** screen.

## 11. How to Remove

- Menu **`7`** → type `y` → Codex is removed.
- "Also delete login info (settings)?" → usually **`n`** (handy for next time).
- To restore, reinstall via menu **`3`**.

## 12. Folder Structure

```text
Codex-CLI_One-Click_Kit/
├─ Codex-CLI_One-Click_Kit.bat   # Executable (double-click)
├─ README.md                     # Full manual (Korean, primary)
├─ README.en.md                  # Full manual (English)
├─ 왕초보_시작_가이드.md            # Beginner step-by-step guide (Korean)
├─ Beginner_Guide_EN.md          # Beginner guide (English)
├─ 오류대처_명령어_치트시트.md       # Errors & commands quick reference
├─ LICENSE                       # Apache License 2.0
└─ *.pdf                         # PDF versions of the docs above
```

> Keep these files **together in one folder**. Moving them apart can break the help links.

## 13. Environment Variables

- This kit requires **no environment variables to set up.** Just double-click.
- Values the kit handles automatically:
  - It adds `%APPDATA%\npm` (npm global path) to `PATH` so the `codex` command is recognized.
  - Settings are stored in `%LOCALAPPDATA%\codex-cli-one-click-kit\`, and login info in `%USERPROFILE%\.codex\`.
- (Optional) To use an **OpenAI API key** instead of account login, follow Codex's method (`codex login` or the `OPENAI_API_KEY` environment variable). **Never store an API key in this folder or any public location.**

## 14. Build · Test · Distribution

- **Build:** None needed. It's a pure Windows batch script (`.bat`) — no compilation.
- **Test:** Double-click `Codex-CLI_One-Click_Kit.bat` → if the menu appears and **Enter** starts Codex, it works. For an environment check, use menu **`6` (diagnose)**.
- **Distribution:** Zip the whole folder and share it, or let people get it from the GitHub repo. The recipient just **unzips and double-clicks the `.bat`**. (The kit guides/installs Node.js and Codex.)

## 15. Security · Operations Notes

- This kit **contains no API keys or passwords**, and does not send your files anywhere.
- **What you type while using Codex** is sent to OpenAI's servers for processing → **do not enter personal data, passwords, or confidential information.**
- **Review** AI-generated code and commands **before running them**. When unsure, switch to **read-only** mode in menu `5`.
- In folders with important data (Desktop, Documents, etc.), avoid "edit files" mode, or confirm once more when the kit's warning appears.
- On first run, the **"Windows protected your PC (SmartScreen)"** warning is normal → `More info` → `Run anyway`.
- Enable **two-factor authentication (MFA)** for login. On shared PCs, run `codex logout` when done.

---

## License · Copyright · Commercial Use (Please Read)

**This kit (the one-click helper)**
- License: **Apache License 2.0** (full text in the `LICENSE` file)
- Copyright: **Copyright 2026 SoDam AI Studio**
- Commercial use: Under Apache-2.0, **commercial use, modification, and redistribution are permitted**, provided that you **include the copyright notice and a copy of the license**, **state any changes** you made, and **do not use the "SoDam AI Studio" name/trademarks for endorsement or promotion without permission.** The software is provided **"AS IS", without warranty.**

**Codex CLI itself (the OpenAI program this kit installs)**
- `@openai/codex` is **OpenAI's work**, distributed under the **Apache License 2.0**. (Repository: <https://github.com/openai/codex>)
- This kit does **not** bundle or redistribute Codex; it only helps **install** it from the official npm source.

**Using OpenAI Services (account · API)**
- To **use** Codex you need an OpenAI account (ChatGPT plan) or an OpenAI API key, and such use is governed by **OpenAI's Terms of Use and policies**. Verify the scope of commercial use, pricing, and limits in **OpenAI's official terms**.

**Trademark Notice**
- **OpenAI**, **Codex**, and **ChatGPT** are trademarks of OpenAI. This kit is an **unofficial helper, not affiliated with OpenAI**, and implies no partnership or endorsement.

## Disclaimer

- This kit is provided **"AS IS", without warranty**; you are **responsible** for the results of using it.
- **Always review** AI-generated code, answers, and commands. For folders with important data, prefer **read-only mode**, and double-check unfamiliar commands before running them.
- This kit does not send your files anywhere. However, when you use Codex, your input is sent to OpenAI's servers for processing (be careful with personal/sensitive data).
