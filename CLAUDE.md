# CLAUDE.md

## Project Overview

Dotfiles repo that mirrors `~/` via rsync. Every file/directory here (except excluded ones) gets copied directly to the home directory by `bootstrap.sh`.

## Key Commands

```bash
./bootstrap.sh        # rsync dotfiles to ~/ (see exclude list in bootstrap.sh)
./bootstrap.sh -f     # same but skip confirmation prompt
source ~/.zprofile     # reload shell config after changes
```

## Architecture

### Shell Sourcing Order

`.zprofile` is the entry point for login shells and sources files in this order:
1. `.path` — PATH modifications
2. `.exports` — environment variables
3. `.aliases` — shell aliases
4. `.functions` — shell functions
5. `.extra` — machine-specific overrides (NOT tracked)

`.zshrc` sources `.zprofile` (interactive shells), then `.aliases`, `.functions`, `.exports`, `.path`, then `~/.zshrc.local` if present, then loads Oh My Zsh. Nothing sources `~/.local-overrides`. Put machine-specific shell config in `~/.extra` or `~/.zshrc.local`.

### File Structure

```
.zshrc / .zprofile    → Shell config (sourcing entry points)
.aliases              → 60+ aliases (navigation, git, network, macOS)
.functions            → Helper functions (mkcd, extract, backup, etc.)
.exports              → Env vars (editor, history, locale, Android SDK)
.path                 → PATH additions (Homebrew, ~/.local/bin, Volta, Android SDK)
.wgetrc               → wget defaults
brew.sh               → Homebrew package installs (75+ packages)
brew-install.sh       → Installs Homebrew itself
ohmyz.sh              → Installs Oh My Zsh
bootstrap.sh          → Deployment script (rsync to ~/)
.gitignore            → Keeps .extra / .local-overrides out of git
.claude/
  settings.json       → Global Claude Code settings (plugins, permissions, iTerm2 status hooks)
  settings.local.json → Hooks (sensitive-file guard, shfmt) + accumulated permissions
  rules/              → Always-apply rules (context7.md)
  skills/             → sync-dotfiles, add-brew-package, context7-mcp
  agents/             → dotfiles-auditor
```

Not in the repo, by design: `~/.extra` and `~/.local-overrides` (machine-specific, gitignored, and excluded from rsync), plus any work-internal skills under `~/.claude/skills/`. **This repo is public**, so don't commit anything containing internal IDs, secrets, or work-only content.

### brew.sh Section Organization

Packages in `brew.sh` are grouped by category. When adding packages, place them in the correct section:

1. Core Unix Utilities (coreutils, findutils, bash, wget, grep)
2. Networking & Security Tools (nmap, aircrack-ng, knock)
3. Other useful tools / Search & Text (ripgrep, ack, jq, httpie, tree, shfmt)
4. Vendor tools (awscli, gh)
5. Infrastructure tools (terraform, helm)
6. Container tools (docker, docker-compose)
7. Kubernetes tools (kubectl, kubectx, stern, kubens)
8. Databases and data tools (pgcli, postgresql)
9. Mac windows management (rectangle)
10. IDEs (VS Code, IntelliJ, DataGrip, Android Studio)
11. Version Managers (pyenv, nvm, sdkman)
12. Build tools (gradle, sbt)
13. Shell (zsh, oh-my-zsh, plugins)
14. Browsers
15. Chat tools
16. Productivity tools
17. Hardware / Streaming tools
18. Fonts

Each package gets a `#comment` above its `brew install` line.

## Gotchas

- **rsync mirrors directory structure**: A file at `dotfiles/.claude/settings.json` becomes `~/.claude/settings.json`. This means `.claude/settings.json` in this repo IS the global Claude Code config.
- **`settings.local.json` is force-tracked**: The global gitignore at `~/.config/git/ignore` blocks `**/.claude/settings.local.json`, but this repo force-tracks it with `git add -f`. Future changes show up in `git status` normally.
- **Never edit or track `.extra` or `.local-overrides`**: These are machine-specific. A PreToolUse hook blocks edits to them, and bootstrap.sh excludes them so rsync can't clobber the live copies.
- **bootstrap.sh excludes repo-only files**: `.git/`, `.DS_Store`, `.osx`, `bootstrap.sh`, `README.md`, `LICENSE`, `CLAUDE.md`, `.gitignore`, `.extra`, and `.local-overrides`. CLAUDE.md is excluded because a copy at `~/CLAUDE.md` would load into every Claude session under `~`. When you add a repo-only file, add it to the exclude list.
- **Check which side is newer before syncing**: Drift happens both ways. Some files get edited live in `~` (e.g. `.aliases`, `~/.claude/settings.json`). Others are edited in the repo but never deployed (e.g. `brew.sh`, `settings.local.json`). Compare mtimes and contents before copying in either direction.
- **iTerm2 rewrites `~/.claude/settings.json`**: Enabling iTerm2's Claude Code integration adds `cc-status` hooks for every event and reserializes the file with escaped slashes (`\/`). Normalize it with `jq . ~/.claude/settings.json > .claude/settings.json` when capturing. The hooks call `~/.config/iterm2/cc-status`, a symlink that iTerm2 creates and this repo doesn't track.
- **`cp` is aliased to interactive**: Use `command cp -f` in scripts and sync steps, or copies will silently prompt and skip.
- **`shfmt` auto-formatting**: A PostToolUse hook runs `shfmt` on `.sh` files after edits. Install shfmt first: `brew install shfmt`.
- **brew.sh uses `--cask` for GUI apps**: Formulae are CLI tools; casks are `.app` bundles. Always use `brew install --cask` for GUI apps in `brew.sh`.
- **`settings.local.json` churns**: Plugin hooks and session permissions accumulate per-session. Expect noisy diffs — commit intentionally, not reflexively.

## Git Workflow

- Always use feature branches — never commit directly to `main`
- Open PRs for all changes

## Code Style

- Shell scripts use tabs for indentation (match existing `bootstrap.sh` style)
- Aliases use double quotes for values
- Comments in `brew.sh`: `#description` (no space after `#` for inline comments)
- Commit messages: imperative mood, concise first line
