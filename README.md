# 🛠️ Dotfiles

Welcome to my personal dotfiles repo — the configuration files that help power my development environment. These files are tailored to my workflow and preferences, covering shell, editor, terminal, and other dev tools. Do not blindly copy my configurations without careful inspection. Because something works for me DOES NOT mean it works for you.

## 🧠 Philosophy

Minimal, reproducible, and pragmatic. These dotfiles are meant to:
- Provide consistency across machines
- Be easily bootstrapped on a new environment
- Stay as close to defaults as practical
- Prioritize performance and developer ergonomics

---

## 📦 What’s Included?

### Shell
- **Zsh** with [Oh My Zsh](https://ohmyz.sh/)
- Custom aliases, functions, and prompt tweaks
- Completion and history tuning

### Editor
- **VS Code** configuration
- Plugin manager setup
- Sensible defaults and key mappings

### Terminal
- iTerm2 configuration (theme, font, shortcuts)
- Color schemes and terminal multiplexer (e.g., `tmux`) settings

### Git
- Global `.gitconfig` and `.gitignore_global`
- Useful aliases (e.g., `lg`, `st`, `co`, `br`, etc.)
- Commit signing and diff highlighting

### Others
`ripgrep`, `bat`, and other CLI tools
- System defaults (macOS tweaks)
- Dev toolchains setup (JVM (Java, Scala, Kotlin), Node, Python, Go, etc.)

---

## 🚀 Setup

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/git/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.


### Automated
To install, `cd` into your local `dotfiles` repository (Wherever that may be, in my case `~/git/dotfiles`) and then:

```bash
./bootstrap.sh
```

```bash
./ohmyz.sh
```

```bash
./brew-install.sh
```

```bash
./brew.sh
```

🙋‍♂️ About

Maintained by @StevenGall. Built for fast onboarding and environment reproducibility. I hate having to set up new machines and this is the most pragmatic way to ensure I have everything I need to be productive.
