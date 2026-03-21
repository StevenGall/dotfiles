# Dotfiles

Personal dotfiles for a reproducible macOS development environment. These files are tailored to my workflow and preferences. **Do not blindly copy my configurations** — review the code and remove things you don't need before using.

## Philosophy

Minimal, reproducible, and pragmatic:
- Consistency across machines
- Easily bootstrapped on a new environment
- Stay close to defaults where practical
- Prioritize performance and developer ergonomics

---

## What's Included

### Shell Configuration

| File | Purpose |
|------|---------|
| `.zshrc` | Main Zsh config — loads Oh My Zsh, plugins, and sources all dotfiles below |
| `.zprofile` | Login shell init — sets up Homebrew, PATH, and sources dotfiles |
| `.aliases` | 60+ aliases for navigation, git, networking, macOS utilities, and more |
| `.functions` | Helper functions: `mkcd`, `extract`, `backup`, `dirsize`, git wrappers |
| `.exports` | Environment variables: editor, history, locale, Node/Python settings |
| `.path` | PATH additions: Homebrew, `~/.local/bin`, `~/bin`, Volta |
| `.wgetrc` | wget defaults: timeouts, retries, ad/tracker URL filtering |
| `.extra` | **Not tracked** — machine-specific overrides (secrets, tokens, etc.) |
| `.local-overrides` | **Not tracked** — template for machine-specific PATH/aliases/env vars |

### Development Tools (via `brew.sh`)

The `brew.sh` script installs 70+ packages organized by category:

- **Core Unix**: coreutils, findutils, bash, wget, grep, openssh, tmux
- **Search & Text**: ripgrep, ack, jq, httpie, tree
- **Networking**: nmap, aircrack-ng, knock, grpcurl
- **Cloud & IaC**: awscli, terraform, terraform-docs, helm
- **Containers & K8s**: docker, docker-compose, kubectl, kubectx, kubens, stern
- **Databases**: postgresql, pgcli
- **Version Managers**: nvm (Node), pyenv (Python), sdkman (Java/JDK)
- **Build Tools**: gradle, sbt
- **IDEs**: VS Code, Cursor, IntelliJ IDEA, DataGrip (with CLI variants)
- **Shell**: zsh, oh-my-zsh, zsh-syntax-highlighting, zsh-autosuggestions
- **Apps**: iTerm2, Rectangle, Google Chrome, Firefox, Slack, Zoom, 1Password

### Claude Code Configuration

The `.claude/` directory contains [Claude Code](https://claude.com/claude-code) configuration that gets deployed to `~/.claude/` via bootstrap:

| File | Purpose |
|------|---------|
| `settings.json` | Global settings: model preference, enabled plugins, voice mode |
| `settings.local.json` | Permissions (pre-approved commands) and hooks |
| `skills/sync-dotfiles/` | `/sync-dotfiles` — bidirectional diff/sync between repo and `~/` |
| `skills/add-brew-package/` | `/add-brew-package` — add packages to `brew.sh` in the correct section |
| `agents/dotfiles-auditor.md` | Subagent that audits installed packages vs repo for drift |

**Hooks:**
- **PreToolUse**: Blocks edits to sensitive files (`.env`, `.extra`, `.local-overrides`)
- **PostToolUse**: Auto-formats shell scripts with `shfmt` after edits

---

## Setup

### Quick Start

Clone the repo and run the scripts in order:

```bash
git clone https://github.com/StevenGall/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles
```

**1. Deploy dotfiles** — copies config files to `~/` via rsync:
```bash
./bootstrap.sh
```

**2. Install Oh My Zsh** — Zsh framework for plugins and themes:
```bash
./ohmyz.sh
```

**3. Install Homebrew** — macOS package manager:
```bash
./brew-install.sh
```

**4. Install packages** — all dev tools, apps, and utilities:
```bash
./brew.sh
```

### How It Works

`bootstrap.sh` uses `rsync` to copy dotfiles from this repo into your home directory. It excludes `.git/`, `.DS_Store`, `bootstrap.sh`, `README.md`, and `LICENSE`. The directory structure mirrors `~/`, so a file at `dotfiles/.claude/settings.json` becomes `~/.claude/settings.json`.

### Updating

To pull the latest changes and redeploy:
```bash
cd ~/git/dotfiles && ./bootstrap.sh
```

To capture live config changes back into the repo, use the `/sync-dotfiles` Claude Code skill or manually copy files.

### Machine-Specific Config

For settings that shouldn't be committed (API keys, work-specific aliases, etc.):
- Edit `~/.extra` — sourced by `.zprofile` but not tracked by git
- Edit `~/.local-overrides` — template included in repo for reference

---

## About

Maintained by [@StevenGall](https://github.com/StevenGall). Built for fast onboarding and environment reproducibility.
