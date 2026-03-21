# CLAUDE.md

## Project Overview

Dotfiles repo that mirrors `~/` via rsync. Every file/directory here (except excluded ones) gets copied directly to the home directory by `bootstrap.sh`.

## Key Commands

```bash
./bootstrap.sh        # rsync dotfiles to ~/ (excludes .git, .DS_Store, bootstrap.sh, README.md, LICENSE)
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

`.zshrc` loads Oh My Zsh, then sources `.aliases`, `.functions`, `.exports`, `.path`.

### File Structure

```
.zshrc / .zprofile    → Shell config (sourcing entry points)
.aliases              → 60+ aliases (navigation, git, network, macOS)
.functions            → Helper functions (mkcd, extract, backup, etc.)
.exports              → Env vars (editor, history, locale, Node/Python)
.path                 → PATH additions (Homebrew, ~/.local/bin, Volta)
.wgetrc               → wget defaults
.extra                → Machine-specific secrets — NEVER edit or track
.local-overrides      → Machine-specific template — NEVER edit or track
brew.sh               → Homebrew package installs (70+ packages)
bootstrap.sh          → Deployment script (rsync to ~/)
.claude/              → Claude Code config (settings, hooks, skills, agents)
```

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
10. IDEs (VS Code, Cursor, IntelliJ, DataGrip + CLI variants)
11. Version Managers (pyenv, nvm, sdkman)
12. Build tools (gradle, sbt)
13. Shell (zsh, oh-my-zsh, plugins)
14. Browsers
15. Chat tools
16. Productivity tools

Each package gets a `#comment` above its `brew install` line.

## Gotchas

- **rsync mirrors directory structure**: A file at `dotfiles/.claude/settings.json` becomes `~/.claude/settings.json`. This means `.claude/settings.json` in this repo IS the global Claude Code config.
- **`settings.local.json` is force-tracked**: The global gitignore at `~/.config/git/ignore` blocks `**/.claude/settings.local.json`, but this repo force-tracks it with `git add -f`. Future changes show up in `git status` normally.
- **Never edit `.extra` or `.local-overrides`**: These are machine-specific. A PreToolUse hook blocks edits to them.
- **`shfmt` auto-formatting**: A PostToolUse hook runs `shfmt` on `.sh` files after edits. Install shfmt first: `brew install shfmt`.

## Code Style

- Shell scripts use tabs for indentation (match existing `bootstrap.sh` style)
- Aliases use double quotes for values
- Comments in `brew.sh`: `#description` (no space after `#` for inline comments)
- Commit messages: imperative mood, concise first line
