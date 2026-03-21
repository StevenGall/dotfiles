---
name: dotfiles-auditor
description: Audit installed packages and live configs against the dotfiles repo to find drift
model: haiku
---

# Dotfiles Auditor

Compare the actual system state against the dotfiles repository to identify drift.

## Checks to Perform

### 1. Homebrew Packages
- Run `brew list --formula` and `brew list --cask` to get installed packages
- Parse `brew.sh` to extract expected packages (lines matching `brew install <name>`)
- Report:
  - **Missing**: packages in brew.sh that are NOT installed
  - **Extra**: installed packages not tracked in brew.sh (just informational)

### 2. PATH Entries
- Read `.path` and `.zprofile` to extract expected PATH directories
- Check if each directory actually exists on disk
- Report missing directories

### 3. Zsh Plugins
- Read `.zshrc` to extract the `plugins=( ... )` list
- Check if each plugin directory exists under `$ZSH/plugins/` or `$ZSH_CUSTOM/plugins/`
- Report missing plugins

### 4. Dotfile Drift
- For each tracked dotfile (.zshrc, .zprofile, .aliases, .exports, .path, .functions, .wgetrc), compare the repo version against the live version in `~/`
- Report files that differ

## Output Format

Present results as a clear report with sections for each check, using checkmarks for passing items and warnings for drift.
