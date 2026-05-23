# Codex 專屬懶人包 #10：全平台服務連接與自動化工作流（macOS 版）

> 版本：v1.0-codex-macOS
> 更新日期：2026-05-23
> 語系偏好：預設繁體中文（Taiwan）
> 適用系統：macOS 12 Monterey 及以上版本
> 適用工具：Codex Desktop / Codex CLI / GitHub CLI / MCP 服務

---

## 這個懶人包會幫你做什麼？

本懶人包是將原本 **Anti-Gravity 2 macOS 懶人包**調適成 **Codex** 工作流的版本。它的目標不是安裝一套單一軟體，而是建立一份可交給 Codex 執行、檢查、維護與備份的「專案駕駛艙」。

照著本指南完成設定後，Codex 可以協助你：

1. **NotebookLM 連接**：透過 `notebooklm-mcp-cli` 或 NotebookLM MCP 工具讀取筆記本、來源與查詢結果。
2. **Firebase 連接**：透過 `firebase-tools` 管理專案、部署、查詢設定與驗證登入狀態。
3. **GitHub 連接**：透過 `gh` CLI 或 Codex 的 GitHub connector 讀 repo、備份文件、建立 commit、push 與 PR。
4. **Obsidian 第二大腦連接**：透過本地檔案、MCP vault 工具或 Markdown 目錄讀寫你的筆記。
5. **Codex 專案駕駛艙**：透過 `CODEX.md` 定義開工、收工、專案初始化、文件備份與檢查 SOP。
6. **圖片與文件產出**：使用 Codex 的圖片生成、文件、簡報、試算表等工具，產出可保存到 repo 的素材與成果。

---

## 事前準備：macOS 基礎環境確認

### 1. 安裝 Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Apple Silicon Mac 通常還需要把 Homebrew 加入 PATH：

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. 確認 Python 3、Node.js、Git

```bash
python3 --version
node --version
npm --version
git --version
```

若尚未安裝：

```bash
brew install python node git
```

### 3. 確認 Codex 可操作目前工作目錄

建議將主要專案放在使用者目錄下，例如：

```bash
mkdir -p ~/Documents ~/Projects
```

在 Codex Desktop 中開啟專案時，優先使用清楚的工作目錄，例如 `~/Documents/某專案` 或 `~/Projects/某專案`。這能讓 Codex 的讀檔、改檔、測試與 Git 操作都更穩定。

---

## 第一部分：全平台服務連接指南

### 步驟一：連接 Google NotebookLM

#### 方案 A：使用 NotebookLM CLI

```bash
pip3 install --user notebooklm-mcp-cli
nlm login
nlm list notebooks
```

如果 `nlm` 找不到，先確認 Python 使用者安裝路徑：

```bash
python3 -m site --user-base
```

再把對應的 `bin` 路徑加入 `~/.zshrc`。常見範例：

```bash
echo 'export PATH="$HOME/Library/Python/3.11/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

#### 方案 B：使用 Codex 的 NotebookLM/外掛工具

若你的 Codex 已安裝 NotebookLM 相關 connector 或 plugin，直接在對話中要求：

```text
請讀取我的 NotebookLM 筆記本清單，列出最近使用的 5 個筆記本。
```

Codex 會優先使用可用的 connector；若沒有可用工具，再回到 CLI 方案。

---

### 步驟二：連接 Firebase

安裝 Firebase CLI：

```bash
npm install -g firebase-tools
```

登入並驗證：

```bash
firebase login
firebase projects:list
```

如果瀏覽器登入流程卡住：

```bash
firebase login --no-localhost
```

若 `npm install -g` 權限不足，建議改用使用者層級 npm prefix：

```bash
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
npm install -g firebase-tools
```

在 Codex 中可要求：

```text
請檢查 Firebase CLI 是否可用，列出我目前可存取的 Firebase 專案。
```

---

### 步驟三：連接 GitHub

安裝 GitHub CLI：

```bash
brew install gh
```

登入：

```bash
gh auth login --web --git-protocol https
gh auth status
```

設定 Git 使用者資訊：

```bash
git config --global user.name "你的名字"
git config --global user.email "你的email@example.com"
```

Codex 備份文件到 GitHub 時，通常會執行這個流程：

```bash
git status
git add README.md CODEX.md 10-Codex專屬懶人包-macOS版.md
git commit -m "Add Codex macOS lazy pack guide"
git push origin main
```

如果 `gh auth status` 顯示 token 失效，請重新登入：

```bash
gh auth logout -h github.com
gh auth login --web --git-protocol https
```

---

### 步驟四：連接 Obsidian 第二大腦

#### 方案 A：Codex 直接讀寫本地 Markdown Vault

只要 Obsidian Vault 在 Codex 可讀寫的目錄內，就可以直接請 Codex 操作 Markdown 檔：

```text
請讀取 ~/Documents/ObsidianVault/每日任務/今日任務.md，整理今天要做的事。
```

常見 Vault 路徑：

```text
~/Documents/ObsidianVault
~/Obsidian
~/Library/Mobile Documents/iCloud~md~obsidian/Documents/你的Vault名稱
```

#### 方案 B：使用 mcpvault

```bash
npm install -g @bitbonsai/mcpvault
mcpvault init --vault ~/Documents/ObsidianVault
mcpvault start
```

啟動後可要求 Codex：

```text
請使用 vault 工具讀取我的 Obsidian 筆記，找出今日任務和本週專案。
```

---

## 第二部分：Codex 的圖片、文件與資料產出

Codex Desktop 可以依照可用工具生成或編輯圖片，也可以建立文件、簡報、試算表等成果。使用時請明確指定輸出類型、語言、用途與儲存位置。

範例：

```text
請生成一張關於「AI 教育代理人應用」的繁體中文資訊圖表，
包含個人化學習、教師助理、智慧教室、心理健康預警四區塊，
風格要適合教育簡報使用，並將成果放到這個 repo 的 assets/ 目錄。
```

建議原則：

| 任務 | 建議說法 |
|---|---|
| 圖片 | 指定尺寸、語言、風格、用途 |
| 文件 | 指定 `.docx`、Markdown 或 PDF 目標 |
| 簡報 | 指定受眾、頁數、每頁重點 |
| 試算表 | 指定欄位、公式、格式與匯出格式 |
| GitHub 備份 | 指定 commit 訊息與目標 branch |

---

## 第三部分：建立 Codex 專案駕駛艙

在 repo 或主要工作目錄建立 `CODEX.md`：

```bash
touch ~/Documents/CODEX.md
```

建議內容如下：

```markdown
# Codex 專案駕駛艙

## 我的工作環境
- 作業系統：macOS
- 主要工作目錄：~/Documents/
- Obsidian Vault：~/Documents/ObsidianVault/
- GitHub 帳號：GmiiLiao
- Firebase 專案：請執行 `firebase projects:list` 確認

## 開工 SOP

請 Codex 依序完成：
1. 顯示目前台北時間與星期
2. 讀取 Obsidian 今日任務
3. 檢查目前 repo 的 `git status`
4. 檢查 GitHub / Firebase / NotebookLM 連線狀態
5. 整理今日工作準備報告

## 收工 SOP

請 Codex 依序完成：
1. 檢查今日修改的檔案
2. 摘要重要變更與風險
3. 詢問是否 commit / push
4. 建立或更新 Obsidian 工作日誌
5. 提醒明日優先事項

## 專案初始化 SOP

請 Codex 依序完成：
1. 詢問專案名稱與用途
2. 建立專案資料夾
3. 初始化 git repo、README、.gitignore、CODEX.md
4. 建立 GitHub repo 並推送
5. 建立 Obsidian 專案筆記
```

使用方式：

```text
請依照 CODEX.md 執行開工 SOP。
```

或：

```text
請依照 CODEX.md 執行收工 SOP，先整理狀態，不要直接 commit。
```

---

## 第四部分：Codex 備份到 GitHub 的安全流程

請 Codex 備份前先執行：

```bash
git status
git diff --stat
git diff
```

確認變更後再執行：

```bash
git add README.md CODEX.md 10-Codex專屬懶人包-macOS版.md
git commit -m "Add Codex macOS lazy pack guide"
git push origin main
```

如果 repo 有使用 branch 工作流：

```bash
git checkout -b codex/add-codex-lazy-pack
git add README.md CODEX.md 10-Codex專屬懶人包-macOS版.md
git commit -m "Add Codex macOS lazy pack guide"
git push -u origin codex/add-codex-lazy-pack
```

再請 Codex 建立 PR。

---

## macOS 專屬實用技巧

### 環境變數持久化

macOS 預設 shell 是 zsh，常用設定檔為 `~/.zshrc` 或 `~/.zprofile`：

```bash
nano ~/.zshrc
source ~/.zshrc
```

常見設定：

```bash
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/Library/Python/3.11/bin:$PATH"
```

### 查看隱藏檔

```bash
ls -la
```

Finder 可按：

```text
Command + Shift + .
```

### Windows 到 macOS 路徑對照

| Windows | macOS |
|---|---|
| `C:\Users\使用者名稱\` | `~/` 或 `/Users/使用者名稱/` |
| `C:\Users\使用者名稱\Documents\` | `~/Documents/` |
| `%APPDATA%` | `~/Library/Application Support/` |
| PowerShell | Terminal / zsh |
| `$env:變數="值"` | `export 變數="值"` |

---

## 常見問題排解

### Q: Codex 不能 push 到 GitHub？

先檢查：

```bash
gh auth status
git remote -v
git branch --show-current
```

若 `gh` token 失效：

```bash
gh auth logout -h github.com
gh auth login --web --git-protocol https
```

### Q: Codex 找不到某個本地檔案？

確認目前工作目錄：

```bash
pwd
ls -la
```

若檔案在工作區外，請在對話中提供完整路徑，或把專案移到 Codex 可讀寫的工作目錄。

### Q: Firebase / npm 全域安裝權限不足？

優先使用使用者層級 npm prefix，不建議一開始就使用 `sudo`：

```bash
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Q: NotebookLM CLI 指令找不到？

```bash
python3 -m site --user-base
```

把輸出的使用者目錄底下 `bin` 加進 PATH。

---

## 快速驗證清單

```bash
echo "=== Codex macOS 環境驗證 ==="
python3 --version
node --version
npm --version
git --version
gh --version | head -1
firebase --version
nlm --version 2>/dev/null || echo "NotebookLM CLI 尚未安裝或不在 PATH"
echo "=== 驗證完成 ==="
```

---

## 建議給 Codex 的日常指令

```text
請依照 CODEX.md 執行開工 SOP。
```

```text
請讀取這個 repo，整理今天應該優先處理的文件與程式任務。
```

```text
請把今天修改過的文件整理成 changelog，檢查無誤後備份到 GitHub。
```

```text
請依照 CODEX.md 執行收工 SOP，但 commit 前先讓我確認 diff。
```

---

祝你和 Codex 在 macOS 上順手合作，把工作流變成可讀、可查、可備份的日常系統。
