---
name: add-brew-package
description: Add a Homebrew package to brew.sh in the correct category section with a descriptive comment
disable-model-invocation: true
---

# Add Brew Package

Add a new Homebrew package to `brew.sh`, placed in the correct category section with a descriptive comment matching the existing style.

## Arguments

The user should provide:
- Package name (required)
- Category hint (optional — if not provided, determine from the package type)

## Workflow

1. **Verify the package exists** by running `brew info <package>` to get the description
2. **Read `brew.sh`** to understand the current section organization:
   - Core Unix Utilities
   - Networking & Security Tools
   - Search & Text Processing (other useful tools section)
   - Vendor tools (AWS, GitHub)
   - Infrastructure tools (Terraform, Helm)
   - Container tools (Docker)
   - Kubernetes tools
   - Databases and data tools
   - Mac windows management tools
   - IDEs
   - Version Managers
   - Build tools
   - Shell (zsh, oh-my-zsh, plugins)
   - Browsers
   - Chat tools
   - Productivity tools
3. **Determine the correct section** based on the package's purpose
4. **Add the package** with a comment matching the style: `#description\nbrew install <package>`
5. **Show the user** the exact insertion point and the lines added

## Style Guide

Match the existing comment style in brew.sh:
- Comments start with `#` (no space after `#` for section-inline comments)
- Each package gets a one-line description comment above the `brew install` line
- Keep alphabetical order within sections where possible
