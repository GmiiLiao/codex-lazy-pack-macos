# Codex macOS 懶人包工作流程

這份文件把 `09-AntiGravity專屬懶人包-macOS版.md` 的核心內容整理成 Codex 可重複執行的工作流程。完整背景請看 `10-Codex專屬懶人包-macOS版.md`，服務狀態可用 `scripts/check-services.sh` 一鍵檢查。

---

## 1. macOS 基礎環境檢查

### 安裝 Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Apple Silicon Mac 建議加入 shell 環境：

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 確認 Python、Node.js、npm、Git

```bash
python3 --version
node --version
npm --version
git --version
```

若缺少工具：

```bash
brew install python node git
```

---

## 2. NotebookLM 連接流程

### 安裝 NotebookLM CLI

```bash
pip3 install --user notebooklm-mcp-cli
```

### 登入與驗證

```bash
nlm login
nlm list notebooks
```

若 `nlm` 找不到，先查 Python 使用者安裝路徑：

```bash
python3 -m site --user-base
```

再把對應的 `bin` 路徑加入 `~/.zshrc`。常見範例：

```bash
echo 'export PATH="$HOME/Library/Python/3.11/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Codex 指令範例

```text
請使用 NotebookLM CLI 列出我的筆記本，並整理最近更新的 5 個。
```

---

## 3. Firebase 連接流程

### 安裝 Firebase CLI

```bash
npm install -g firebase-tools
```

### 登入與驗證

```bash
firebase login
firebase projects:list
```

若瀏覽器登入流程無法開啟：

```bash
firebase login --no-localhost
```

若全域 npm 安裝權限不足，建議改用使用者層級安裝位置：

```bash
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
npm install -g firebase-tools
```

### Codex 指令範例

```text
請檢查 Firebase CLI 是否可用，列出我目前可存取的 Firebase 專案。
```

---

## 4. GitHub CLI 連接流程

### 安裝 GitHub CLI

```bash
brew install gh
```

### 登入與驗證

```bash
gh auth login --web --git-protocol https
gh auth status
```

### 設定 Git 作者資訊

```bash
git config --global user.name "你的名字"
git config --global user.email "你的email@example.com"
```

### 驗證目前 repo

```bash
git status
git remote -v
gh repo view GmiiLiao/codex-lazy-pack-macos
```

### Codex 指令範例

```text
請檢查 git status 和 git diff，確認文件變更後提交並推送到 GitHub。
```

---

## 5. Obsidian Vault 連接流程

### 方案 A：Codex 直接讀寫本地 Markdown

常見 Vault 路徑：

```text
~/Documents/ObsidianVault
~/Obsidian
~/Library/Mobile Documents/iCloud~md~obsidian/Documents/你的Vault名稱
```

驗證：

```bash
ls ~/Documents/ObsidianVault/
ls ~/Documents/ObsidianVault/每日任務/
```

### 方案 B：使用 mcpvault

```bash
npm install -g @bitbonsai/mcpvault
mcpvault init --vault ~/Documents/ObsidianVault
mcpvault start
```

### Codex 指令範例

```text
請讀取 ~/Documents/ObsidianVault/每日任務/今日任務.md，整理今天要做的事。
```

---

## 6. 繁體中文資訊圖產出流程

Codex 可透過可用的圖片生成工具產出資訊圖，建議將成果放在 `assets/`。

### Prompt 範例

```text
請生成一張關於「AI 教育代理人應用」的繁體中文資訊圖表，
包含個人化學習、教師助理、智慧教室、心理健康預警四區塊。
風格要適合教育簡報使用，所有文字使用繁體中文。
輸出後請將檔案放到 assets/ 目錄，並在 README 補上用途說明。
```

### 命名建議

```text
assets/ai_educational_agents_infographic_zh.png
assets/codex_workflow_overview.png
```

---

## 7. 專案駕駛艙流程

Codex 版使用 `CODEX.md`，Anti-Gravity 版使用 `ANTIGRAVITY.md`。兩者的用途相同：把日常工作流程寫成 AI 助理可以照做的 SOP。

### 開工 SOP

```text
請依照 CODEX.md 執行開工 SOP。
```

建議包含：

1. 顯示目前台北時間與星期。
2. 檢查目前 repo、branch、remote 和工作樹狀態。
3. 讀取 Obsidian 今日任務。
4. 檢查 GitHub、Firebase、NotebookLM、Obsidian 連線。
5. 整理今日工作準備報告。

### 收工 SOP

```text
請依照 CODEX.md 執行收工 SOP，但 commit 前先讓我確認 diff。
```

建議包含：

1. 執行 `git status` 和 `git diff --stat`。
2. 摘要今日變更、風險與未驗證事項。
3. 詢問是否 commit / push。
4. 更新 Obsidian 工作日誌。
5. 列出明日優先事項。

### 專案初始化 SOP

```text
請依照 CODEX.md 初始化新專案。
```

建議包含：

1. 詢問專案名稱、用途和 GitHub 可見性。
2. 建立專案資料夾。
3. 初始化 git repo、README、`.gitignore`、`CODEX.md`。
4. 建立 GitHub repo 並推送。
5. 建立 Obsidian 專案筆記。
6. 如有需要，再初始化 Firebase。

---

## 8. 一鍵服務檢查

完成設定後，直接執行：

```bash
scripts/check-services.sh
```

這個腳本會檢查：

- Python、Node.js、npm、Git
- 目前 git branch、origin、工作樹狀態
- GitHub CLI 認證與 repo 可讀性
- Firebase CLI 與專案清單
- NotebookLM CLI 與筆記本清單
- Obsidian Vault 與今日任務檔

若 Obsidian Vault 不在預設位置：

```bash
OBSIDIAN_VAULT="/path/to/your/vault" scripts/check-services.sh
```

---

## 9. macOS 常見問題排解

### `pip3 install` 出現 Permission denied

```bash
pip3 install --user notebooklm-mcp-cli
```

或使用虛擬環境：

```bash
python3 -m venv ~/.venv/codex-lazy-pack
source ~/.venv/codex-lazy-pack/bin/activate
pip install notebooklm-mcp-cli
```

### `npm install -g` 出現 Permission denied

```bash
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### `firebase login` 無法開啟瀏覽器

```bash
firebase login --no-localhost
```

### `gh auth status` 顯示 token 失效

```bash
gh auth logout -h github.com
gh auth login -h github.com --web --git-protocol https
gh auth status
```

### Apple Silicon Homebrew 路徑不正確

```bash
which brew
```

Apple Silicon 通常應該是：

```text
/opt/homebrew/bin/brew
```

---

## 10. 建議日常節奏

### 開工

```bash
scripts/check-services.sh
```

```text
請依照 CODEX.md 執行開工 SOP。
```

### 工作中

```text
請根據 README.md、CODEX.md 和 docs/workflows.md，協助我完成目前任務並保持 GitHub 備份。
```

### 收工

```text
請依照 CODEX.md 執行收工 SOP，先整理 diff 和工作日誌，再問我要不要 commit / push。
```
