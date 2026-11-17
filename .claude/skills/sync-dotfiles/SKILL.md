---
name: sync-dotfiles
description: Compare live dotfiles (~/) against the repo and sync in either direction. Shows diffs, lets you pick which files to sync.
disable-model-invocation: true
---

# Sync Dotfiles

Compare the live dotfiles in the home directory against this repository and optionally sync changes in either direction.

## Workflow

1. **Diff phase**: For each tracked dotfile, compare `~/.<file>` against the repo version using `diff`.

   Tracked files to compare:
   - `.zshrc`
   - `.zprofile`
   - `.aliases`
   - `.exports`
   - `.path`
   - `.functions`
   - `.wgetrc`
   - `.claude/settings.json` (normalize with `jq .` when capturing — iTerm2 rewrites it with escaped slashes)
   - `.claude/settings.local.json`
   - `.claude/rules/*`, `.claude/skills/*`, `.claude/agents/*` (also check `~/.claude/` for new ones not yet in the repo)
   - `brew.sh`

   Use file mtimes to determine direction: don't assume home is always newer.

2. **Report phase**: Present a summary table showing which files differ and the direction of changes:
   - `SAME` — no differences
   - `REPO → HOME` — repo has newer changes not yet deployed
   - `HOME → REPO` — live config has changes not yet captured in repo

3. **Action phase**: Ask the user which direction to sync:
   - **Deploy** (repo → home): Copy repo versions to `~/` using rsync (same as bootstrap.sh)
   - **Capture** (home → repo): Copy live versions into the repo for committing
   - **Cherry-pick**: Let the user select individual files to sync in either direction

## Important

- Never sync `.extra` or `.local-overrides` — these are machine-specific by design
- This repo is public: never capture skills or files with work-internal content, IDs, or secrets
- Use `command cp -f` (`cp` is aliased to interactive)
- Always show the diff before overwriting anything
- After syncing, suggest running `source ~/.zprofile` if shell files changed
