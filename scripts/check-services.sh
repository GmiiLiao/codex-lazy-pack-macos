#!/usr/bin/env bash

set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OBSIDIAN_VAULT="${OBSIDIAN_VAULT:-$HOME/Documents/ObsidianVault}"

ok_count=0
warn_count=0

print_section() {
  printf '\n== %s ==\n' "$1"
}

ok() {
  ok_count=$((ok_count + 1))
  printf 'OK   %s\n' "$1"
}

warn() {
  warn_count=$((warn_count + 1))
  printf 'WARN %s\n' "$1"
}

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

run_capture() {
  "$@" 2>&1
}

print_section "Codex macOS lazy pack service check"
printf 'Time: %s\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')"
printf 'Repo: %s\n' "$ROOT_DIR"

print_section "Local tools"
if has_cmd python3; then
  ok "Python: $(python3 --version 2>&1)"
else
  warn "python3 not found"
fi

if has_cmd node; then
  ok "Node: $(node --version 2>&1)"
else
  warn "node not found"
fi

if has_cmd npm; then
  ok "npm: $(npm --version 2>&1)"
else
  warn "npm not found"
fi

if has_cmd git; then
  ok "Git: $(git --version 2>&1)"
else
  warn "git not found"
fi

print_section "Git repository"
if git -C "$ROOT_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch="$(git -C "$ROOT_DIR" branch --show-current 2>/dev/null || true)"
  remote="$(git -C "$ROOT_DIR" remote get-url origin 2>/dev/null || true)"
  status="$(git -C "$ROOT_DIR" status --short 2>/dev/null || true)"
  ok "Branch: ${branch:-detached}"
  ok "Origin: ${remote:-not configured}"
  if [ -z "$status" ]; then
    ok "Working tree clean"
  else
    warn "Working tree has changes"
    printf '%s\n' "$status"
  fi
else
  warn "not inside a git repository"
fi

print_section "GitHub"
if has_cmd gh; then
  if auth_output="$(run_capture gh auth status)"; then
    ok "GitHub CLI authenticated"
  else
    warn "GitHub CLI auth needs attention"
    printf '%s\n' "$auth_output"
  fi

  if repo_output="$(run_capture gh repo view GmiiLiao/codex-lazy-pack-macos --json nameWithOwner,url,defaultBranchRef)"; then
    ok "GitHub repo reachable: GmiiLiao/codex-lazy-pack-macos"
  else
    warn "GitHub repo view failed"
    printf '%s\n' "$repo_output"
  fi
else
  warn "gh not found"
fi

print_section "Firebase"
if has_cmd firebase; then
  version="$(firebase --version 2>&1 || true)"
  ok "Firebase CLI: $version"
  if projects_output="$(run_capture firebase projects:list)"; then
    ok "Firebase projects list succeeded"
  else
    warn "Firebase projects list failed"
    printf '%s\n' "$projects_output"
  fi
else
  warn "firebase CLI not found"
fi

print_section "NotebookLM"
if has_cmd nlm; then
  version="$(nlm --version 2>&1 | head -n 1 || true)"
  ok "NotebookLM CLI: $version"
  if notebooks_output="$(run_capture nlm list notebooks)"; then
    count="$(printf '%s\n' "$notebooks_output" | grep -c '"title"' || true)"
    ok "NotebookLM notebooks list succeeded (${count} notebooks reported)"
  else
    warn "NotebookLM notebooks list failed"
    printf '%s\n' "$notebooks_output"
  fi
else
  warn "nlm not found"
fi

print_section "Obsidian"
if [ -d "$OBSIDIAN_VAULT" ]; then
  ok "Vault exists: $OBSIDIAN_VAULT"
  if [ -f "$OBSIDIAN_VAULT/每日任務/今日任務.md" ]; then
    ok "Today task note exists"
  else
    warn "Today task note missing: $OBSIDIAN_VAULT/每日任務/今日任務.md"
  fi
else
  warn "Vault missing: $OBSIDIAN_VAULT"
fi

print_section "Summary"
printf 'OK: %s\n' "$ok_count"
printf 'WARN: %s\n' "$warn_count"

if [ "$warn_count" -gt 0 ]; then
  exit 1
fi
