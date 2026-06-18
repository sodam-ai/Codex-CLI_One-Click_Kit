# Beginner's Start Guide (Made Really Simple)

It's okay if computers/AI are new to you. Just follow the steps below **exactly**.
(Korean version: [`왕초보_시작_가이드.md`](./왕초보_시작_가이드.md) · Full manual: [`README.en.md`](./README.en.md))

---

## Before You Start (Prerequisites)

- A **Windows PC** and an **internet connection**
- A **ChatGPT account** (you can create one for free if you don't have one)
- **Node.js** (a free program): if it's missing, the kit **helps install it for you**. No need to install it in advance.

---

## Step 1. Run the File

1. **Double-click** the file `Codex-CLI_One-Click_Kit.bat`.
2. Success when a **black window** opens showing a Korean menu.

> 💡 **A blue "Windows protected your PC" warning appeared?**
> That's normal — it shows for new files. Click **`More info`** → **`Run anyway`**.

## Step 2. Start (the easiest way)

- When the menu appears, just press the **`Enter`** key once. (= Start Codex)
- The kit checks things for you, and if Codex is missing it **helps install it** and then starts.
  - If it asks to install, press `y` → Enter.

```
    /==================================\
    |      >>>   [  ENTER  ]   <<<      |
    \==================================/
     Press Enter once to start right away!
```

## Step 3. Log In (first time only)

1. A web browser **opens automatically** with the ChatGPT login screen.
2. Log in with your usual **ChatGPT account** (a free account works too).
3. For security, enabling **two-factor authentication (MFA)** is recommended.

> Your login is saved on your PC at `C:\Users\(you)\.codex\`, so you won't need to log in again next time.

## Step 4. Ask It to Do Things (How to Use)

- When it starts, you'll first see **"try asking like this"** examples. You can copy them as-is.
- In the black window, type **what you want, in plain language**, and press `Enter`:
  - `Tell me what files are in this folder`
  - `Explain in simple terms what this code does`
  - `Make a simple notepad program`
- **To quit**, type `/quit`, or press the **`Ctrl`** and **`C`** keys together.

---

## Understanding Modes (Safety)

This kit has two modes. The current mode is shown next to "모드 :" (Mode) at the top of the screen.

| Mode | What it means |
|---|---|
| **Edit files** (default) | The AI can create/modify files **only inside the current folder**. ("Make a notepad app" actually works.) It can **never** touch outside the folder or the rest of your PC. |
| **Read-only** | The AI **never touches files** and only reads. The most conservative option. |

- To switch, use menu **`5` (Change mode)**. Once set, it's remembered.
- If you start in a **personal folder** like Desktop or Documents with "Edit files", the kit asks **"continue?"** once more to keep you safe.

---

## Full Menu Explanation

| Press | What happens |
|---|---|
| **Enter / 1** | Start Codex immediately |
| **2** | Start in another folder (Desktop, Documents, new folder, etc.) |
| **3** | Install / Reinstall |
| **4** | Update to the latest version |
| **5** | Change mode (edit files ↔ read-only) |
| **6** | When it doesn't work — auto-diagnose (saves `진단결과.txt`) |
| **7** | Remove (uninstall Codex) |
| **H** | View help · **Q** Quit |

---

## FAQ

**Q. Do I need to run as administrator?**
→ No. Just double-click.

**Q. At first it says "Enter = start / press R for read-only".**
→ Just press **Enter** (the recommended mode that can also create files). If you prefer read-only, press `R`. Choose once and it's remembered.

**Q. The install seems stuck.**
→ It usually takes 1–2 minutes. It's downloading from the internet, so please wait a moment.

**Q. It says the `codex` command isn't recognized.**
→ **Restart your PC**, then run again. (Your PC may need a moment to recognize the newly installed location.)

**Q. I want to remove it.**
→ Menu **`7`** → `y`. For "Also delete settings?", usually press **`n`** (handy next time). To restore, reinstall via menu `3`.

**Q. I'm stuck on something.**
→ Press menu **`6` diagnose** and capture the screen — it makes finding the cause easy. Keep this kit's files **together in one folder** and don't move them apart.

---

## Troubleshooting (Full Table)

| Symptom | Cause (in plain terms) | Fix |
|---|---|---|
| `codex` not recognized / "command not found" | PC doesn't know the install location yet (PATH) | **Restart the PC**, then run again. If it persists, menu `6` diagnose |
| Install failed | Internet dropped / temporary error | Check internet, then reinstall via menu `3` |
| Login page won't open | Firewall/network blocking | Check internet. Paste the on-screen URL into a browser manually |
| `429` / "Too many requests" | Used too much briefly (usage limit) | Wait the shown time, then retry |
| Says Node version is too old | Outdated Node.js | Reinstall the latest **LTS** (22+) from <https://nodejs.org> |
| Login keeps blocking | Account security settings | Enable **two-factor (MFA)** on your ChatGPT account, then retry |
| Korean text looks broken | Font/encoding | Close the window and run again. If it persists, capture the menu `6` diagnose result |

> If still confused, capture the menu **`6` diagnose** screen and paste it to an AI (ChatGPT/Claude) to ask — it makes finding the cause much easier.

---

## Common Commands (When Typing Directly)

> The menu is usually enough. Below is for typing directly into the black window.

| Command | Meaning |
|---|---|
| `codex` | Start interactively (easiest) |
| `codex "task description"` | Run a task directly — e.g. `codex "explain this code"` |
| `codex exec "task"` | Run once without conversation |
| `codex --version` | Show installed version |
| `codex logout` | Log out |
| `codex --sandbox read-only` | Read-only (won't modify files) |
| `codex --sandbox workspace-write` | Allow edits only inside the current folder |
| `/help` | (while Codex is running) See available features |

---

## Workflow (At a Glance)

```
[Double-click] → [Korean menu] → [Enter = Start]
   → (first time only) log in to ChatGPT
   → choose a working folder
   → ask in plain language  →  AI answers or creates files
   → quit with /quit  →  back to the menu
```

## File / Storage Locations

- **This kit's files**: keep them together in one folder (`.bat`, README, guides, cheat sheet, LICENSE).
- **Kit settings** (remembers mode & last folder): `C:\Users\(you)\AppData\Local\codex-cli-one-click-kit\`
- **Login info**: `C:\Users\(you)\.codex\`
- **Diagnosis result**: `진단결과.txt` (created in this folder by menu `6`)

---

## Good to Know

- **Cost**: A free ChatGPT account has limited use; Plus or higher allows more. Using an API key is billed per usage.
- **Always review** AI-generated code and commands; when unsure, try **read-only** mode first.
- For more, see the full manual [`README.en.md`](./README.en.md).

> This kit is an **unofficial helper**; OpenAI, Codex, and ChatGPT are trademarks of OpenAI. License: **Apache-2.0** (see `LICENSE`).
