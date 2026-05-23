# 快速開始：Codex macOS 懶人包

這份快速開始給已經在 macOS 上使用 Codex 的人。完整說明請看 `10-Codex專屬懶人包-macOS版.md`。

---

## 1. 檢查基礎工具

```bash
python3 --version
node --version
npm --version
git --version
gh --version
```

若缺少 Homebrew：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

若缺少 GitHub CLI：

```bash
brew install gh
gh auth login --web --git-protocol https
```

如果已完成基本設定，也可以直接執行完整檢查：

```bash
scripts/check-services.sh
```

---

## 2. 讓 Codex 讀懂這個 repo

對 Codex 說：

```text
請閱讀 README.md、CODEX.md 和 10-Codex專屬懶人包-macOS版.md，整理這個 repo 的用途。
```

接著可以說：

```text
請依照 CODEX.md 執行開工 SOP。
```

---

## 3. 連接常用服務

### GitHub

```bash
gh auth status
```

### Firebase

```bash
npm install -g firebase-tools
firebase login
firebase projects:list
```

### NotebookLM

```bash
pip3 install --user notebooklm-mcp-cli
nlm login
nlm list notebooks
```

### Obsidian

把你的 Vault 路徑記到 `CODEX.md`，常見位置：

```text
~/Documents/ObsidianVault
~/Library/Mobile Documents/iCloud~md~obsidian/Documents/你的Vault名稱
```

若你的 Vault 不在預設位置，可用環境變數指定：

```bash
OBSIDIAN_VAULT="/path/to/your/vault" scripts/check-services.sh
```

---

## 4. 文件備份到 GitHub

對 Codex 說：

```text
請檢查 git status 和 git diff，確認文件變更後提交並推送到 GitHub。
```

Codex 會依照 `CODEX.md` 的文件備份 SOP 先整理差異，再進行 commit / push。

---

## 5. 推薦日常指令

```text
請依照 CODEX.md 執行開工 SOP。
```

```text
請把今天修改過的文件整理成 changelog，檢查無誤後備份到 GitHub。
```

```text
請依照 CODEX.md 執行收工 SOP，但 commit 前先讓我確認 diff。
```
