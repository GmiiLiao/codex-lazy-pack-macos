# 🌌 Codex / Anti-Gravity 專屬懶人包 — 全平台服務連接與開發自動化指南（macOS 版）

歡迎使用 **Codex / Anti-Gravity 專屬懶人包 macOS 版**！本專案是原版 Windows 懶人包的 macOS 調適版本，並新增 **Codex Desktop / Codex CLI** 工作流版本，為在 **macOS** 上使用 AI 編碼助理的使用者提供一個流暢、可備份、可自動化的開發與服務連接範本。

> 🪟 原版 Windows 懶人包請見：[mathruffian-dot/antigravity-lazy-pack](https://github.com/mathruffian-dot/antigravity-lazy-pack)

透過本專案的指南與設定，您將能夠引導 AI 助理連接 NotebookLM、Firebase、GitHub 以及 Obsidian，並透過專案駕駛艙（`CODEX.md` / `ANTIGRAVITY.md`）實現「開工/收工/專案初始化」的一鍵自動化 SOP。

---

## 🚀 專案核心特色

1. **🍎 macOS 原生優化**：所有指令均針對 macOS Terminal（zsh）調適，移除 Windows 專屬的 PowerShell 限制與繞過技巧。
2. **🔗 全平台服務整合**：完整打通 Google NotebookLM、Firebase、GitHub 與 Obsidian 本地第二大腦。
3. **🤖 Codex 專案駕駛艙 (SOP)**：設定開工、收工、文件備份及專案初始化流程，讓 Codex 自動整理與管理您的工作流。
4. **🎨 原生免 API Key 繁體中文生圖**：配置以繁體中文為優先的優雅資訊圖表生成指南。
5. **📊 實戰成果展示**：收錄真實運作產出的「AI 教育代理人」深度趨勢報告與視覺化圖表。

---

## 📂 檔案目錄說明

* 📄 **[10-Codex專屬懶人包-macOS版.md](10-Codex專屬懶人包-macOS版.md)**：**Codex 版核心指南主檔**，詳細記錄 Codex 在 macOS 上連接服務、產出文件與備份 GitHub 的流程。
* ⚡ **[QUICKSTART.md](QUICKSTART.md)**：Codex 版快速開始，只保留最短可執行路徑。
* 🧭 **[CODEX.md](CODEX.md)**：Codex 專案駕駛艙，定義開工、收工、專案初始化與文件備份 SOP。
* 🛠️ **[scripts/check-services.sh](scripts/check-services.sh)**：一鍵檢查 GitHub、Firebase、NotebookLM、Obsidian 與本機工具狀態。
* 📄 **[09-AntiGravity專屬懶人包-macOS版.md](09-AntiGravity專屬懶人包-macOS版.md)**：Anti-Gravity 版核心指南主檔，保留作為原始對照。
* 🧭 **[ANTIGRAVITY.md](ANTIGRAVITY.md)**：Anti-Gravity 版專案駕駛艙。
* 📝 **[ai_educational_agents_trends.md](ai_educational_agents_trends.md)**：實戰產出的 AI 教育代理人教學與行政應用深度報告（與原版相同）。
* 📊 **[notebooks.example.json](notebooks.example.json)**：NotebookLM 筆記本資料範例，避免直接提交私人筆記本清單。
* 🖼️ **[assets/](assets/)**：圖片、資訊圖表與其他視覺素材的建議存放位置。

> 備註：若要提交實際 `notebooks.json`，請先確認內容不含私人資料、筆記本 ID 或敏感來源資訊。

---

## 🛠️ 快速開始

### 第零步：確認 macOS 基礎環境

```bash
# 安裝 Homebrew（若尚未安裝）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 確認 Python 3、Node.js 已就緒
python3 --version && node --version && npm --version
```

### Codex 使用者可以先閱讀 ⚡ [QUICKSTART.md](QUICKSTART.md)，再進入 📖 [10-Codex專屬懶人包-macOS版.md](10-Codex專屬懶人包-macOS版.md) 完成完整配置：

1. **第一部分**：連接 NotebookLM、Firebase、GitHub 與 Obsidian（macOS 版指令）。
2. **第二部分**：使用 Codex 產出圖片、文件、簡報與試算表。
3. **第三部分**：建立與執行 `CODEX.md` 開工/收工/專案初始化 SOP。
4. **第四部分**：將文件與工作成果安全備份到 GitHub。

完成設定後，可直接執行：

```bash
scripts/check-services.sh
```

Anti-Gravity 使用者則可閱讀 📖 [09-AntiGravity專屬懶人包-macOS版.md](09-AntiGravity專屬懶人包-macOS版.md)。

---

## 🍎 vs 🪟 Windows vs macOS 主要差異對照

| 項目 | Windows 版 | macOS / Codex 版 |
|------|-----------|---------|
| Shell | PowerShell / CMD | Terminal（zsh） |
| NotebookLM 編碼問題 | 需設定 `$env:PYTHONIOENCODING="utf-8"` | ✅ 無需設定，預設 UTF-8 |
| Firebase 執行原則限制 | 需用 `cmd /c firebase ...` 包裝 | ✅ 直接執行 `firebase ...` |
| 環境變數設定 | `$env:變數="值"` | `export 變數="值"` |
| 環境變數持久化 | 系統環境變數設定 | 寫入 `~/.zshrc` |
| 套件管理器 | Chocolatey / winget | **Homebrew** |
| GitHub CLI 安裝 | `winget install gh` | `brew install gh` |
| 清除環境變數 | `$env:GITHUB_TOKEN=""` | `unset GITHUB_TOKEN` |
| 專案駕駛艙 | 依工具自訂 | `CODEX.md` / `ANTIGRAVITY.md` |

---

祝您與 Codex / Anti-Gravity 在 macOS 上對話愉快，享受順手開發與穩定備份的樂趣！🚀🍎
