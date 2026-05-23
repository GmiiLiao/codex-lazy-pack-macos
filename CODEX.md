# Codex 專案駕駛艙

> 版本：v1.0-codex-macOS · 建立於 2026-05-23
> 常用指令：「請執行開工 SOP」、「請執行收工 SOP」、「請初始化新專案」

---

## 我的環境設定

| 項目 | 設定值 |
|------|--------|
| 作業系統 | macOS |
| 主要工作目錄 | ~/Documents/ |
| GitHub 帳號 | GmiiLiao |
| Obsidian Vault | ~/Documents/ObsidianVault/ |
| Firebase 專案 | 以 `firebase projects:list` 為準 |
| NotebookLM | 以 `nlm list notebooks` 或 Codex connector 為準 |

---

## 開工 SOP

請 Codex 依序完成以下步驟：

1. 顯示目前日期時間（台北時間）與星期。
2. 檢查目前工作目錄與 git branch。
3. 讀取 Obsidian Vault 中的今日任務；若找不到，先回報缺少的路徑。
4. 檢查 GitHub、Firebase、NotebookLM 的連線狀態。
5. 整理成「今日工作準備報告」，列出建議優先事項。

---

## 收工 SOP

請 Codex 依序完成以下步驟：

1. 執行 `git status` 與 `git diff --stat`，整理今日修改。
2. 摘要重要變更、風險與尚未驗證的事項。
3. 詢問是否要 commit 與 push，不要直接提交未確認的變更。
4. 若使用者同意，建立 commit 並推送到 GitHub。
5. 建立或更新 Obsidian `工作日誌/YYYY-MM-DD.md`，記錄完成事項、問題與明日計畫。

---

## 專案初始化 SOP

請 Codex 依序完成以下步驟：

1. 詢問專案名稱、用途、是否公開到 GitHub。
2. 在主要工作目錄下建立專案資料夾。
3. 初始化 git repo、`.gitignore`、`README.md`、`CODEX.md`。
4. 建立 GitHub repo 並推送。
5. 建立 Obsidian 專案筆記，包含專案目標、GitHub 連結與建立日期。
6. 如有需要，再初始化 Firebase。

---

## 文件備份 SOP

請 Codex 備份文件到 GitHub 時遵守：

1. 先讀取需求與目標檔案。
2. 編輯前說明即將修改哪些檔案。
3. 完成後執行 `git diff --stat` 與必要檢查。
4. commit message 使用清楚的英文或繁中描述。
5. push 前再次確認目前 branch 與 remote。

---

## 常用快速指令

```bash
# GitHub
gh auth status
gh repo list GmiiLiao --limit 10

# Firebase
firebase projects:list

# NotebookLM
nlm list notebooks

# Obsidian Vault
ls ~/Documents/ObsidianVault/
```

---

*最後更新：2026-05-23 · Codex macOS 版*
