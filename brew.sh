#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we're using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew's installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don't forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
# Installs the GNU core utilities (like ls, cp, mv, cat, date, etc.). These often have more features and behave more consistently with Linux systems compared to the default macOS utilities.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Installs a collection of additional small, useful Unix utilities that aren't part of coreutils, like sponge (soak up standard input and write to a file), ts (timestamp standard input), vidir (edit directory contents in a text editor).
brew install moreutils
# Installs the GNU versions of find, locate, updatedb, and xargs. Again, often preferred for features and compatibility with Linux scripts.
brew install findutils

# Installs a more recent version of the Bash shell than the one typically included with macOS.
brew install bash
# Provides enhanced programmable tab completion for the Bash shell.
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Installs a non-interactive command-line utility for downloading files from the web (HTTP, HTTPS, FTP).
brew install wget

# Install more recent versions of some macOS tools.
# Installs the GNU version of grep, a powerful tool for searching plain-text data sets for lines that match a regular expression.
brew install grep
# Installs a more recent version of OpenSSH (client and server tools like ssh, scp, sshd).
brew install openssh
# Installs a terminal multiplexer. Allows managing multiple terminal sessions within a single window.
brew install tmux
# Installs the GNU Multiple Precision Arithmetic Library, required by programs needing large number calculations.
brew install gmp

# Install some networking tools
# Installs a suite of tools for auditing Wi-Fi network security (WEP/WPA/WPA2 cracking, packet sniffing, etc.).
brew install aircrack-ng
# Installs a port knocking client to trigger firewall rules by sending packets to specific ports in sequence.
brew install knock
# Installs Network Mapper (Nmap), a powerful tool for network exploration, security auditing, and port scanning.
brew install nmap

# Install other useful tools.
# Installs the ubiquitous distributed version control system. Folks should know git.
brew install git
# Installs a command-line search tool optimized for programmers, similar to grep but defaults to searching recursively and ignoring VCS directories.
brew install ack
# Installs an extremely fast command-line search tool that recursively searches directories for a regex pattern.
brew install ripgrep
# Installs Ghostscript, an interpreter for PostScript language and PDF files.
brew install gs
# Installs a text-based web browser for terminal environments.
brew install lynx
# Installs Pipe Viewer, a tool for monitoring the progress of data through a pipeline.
brew install pv
# Installs a utility for renaming multiple files using specified rules (often regex).
brew install rename
# Installs Readline Wrapper, providing editing, history, and completion for commands that lack it.
brew install rlwrap
# Installs a script to copy your SSH public key to a remote machine's authorized_keys file.
brew install ssh-copy-id
# Installs a utility to list directory contents in a tree-like format.
brew install tree
# Installs a visual binary diff tool to compare binary files.
brew install vbindiff
# Installs jq, a lightweight and flexible command-line JSON processor.
brew install jq
# Installs httpie, a command-line HTTP client that makes CLI requests easy.
brew install httpie
# Installs htop, an interactive process viewer for Unix systems.
brew install htop
# Installs a command-line tool for managing Docker containers and images.
brew install grpcurl
#watch is a command-line utility for monitoring the output of a command over time.
brew install watch

#Install vendor tools
#AWS CLI
brew install awscli
#GitHub CLI
brew install gh

#infrastructure tools
brew install terraform 
#generate documentation from terraform code
brew install terraform-docs 
#terraform provider for aws
brew install terraform-provider-aws
#terraform provider for kubernetes
brew install terraform-provider-kubernetes
# Helm is a package manager for Kubernetes.
brew install helm

#Install container tools
brew install docker
# Installs a command-line tool for managing Docker containers and images.
brew install docker-compose

# Kubernetes tools
#Kubernetes CLI - The standard command-line tool for Kubernetes, you can perform all the operations of Kubernetes that are required.
brew install kubectl
#Kubectx is helpful for multi-cluster installations, where you need to switch context between one cluster and another. Rather than type a series of lengthy kubectl command, kubectx works it magic in one short command
brew install kubectx
#kubectl-view-allocations - A tool to help visualize Kubernetes resource allocations.
brew install kubectl-view-allocations
#stern is a tool for filtering and following Kubernetes logs.
brew install stern
#kubens is helpful for switching between Kubernetes namespaces.
brew install kubens

# Databases and data tools
#pgcli is a command-line tool for interacting with PostgreSQL databases.
brew install pgcli
#psql is the standard command-line interface for PostgreSQL.
brew install postgresql


#Install mac windows management tools
brew install rectangle

#IDEs
#VSCode
brew install visual-studio-code
#VSCode CLI
brew install code-cli
#Cursor
brew install cursor
#Cursor CLI
brew install cursor-cli
#intellij idea
brew install intellij-idea
#intellij idea cli
brew install intellij-idea-cli
#datagrip
brew install datagrip
#datagrip cli
brew install datagrip-cli
#pycharm
brew install pycharm
#pycharm cli
brew install pycharm-cli

#Python Node and Java Version Managers
#(Python Version Manager): Similar to nvm for Python. Allows easy installation and switching between multiple Python versions. (Note: Requires separate setup after installation)
brew install pyenv
#node version manager : If you work with Node.js, using a version manager is highly recommended over installing Node directly with Brew. 
brew install nvm
#sdkman is one of the most popular and preferred ways to manage Java (JDK) versions on macOS and Linux systems.
brew tap sdkman/tap
brew install sdkman-cli

#build tools
#gradle is a build automation tool for multi-language software development.
brew install gradle
#sbt is a build tool for Scala and Java projects.
brew install sbt

# A popular replacement for the default macOS Terminal application with many more features (split panes, profiles, triggers, better search, etc.)
brew install iterm2

#zsh is a powerful shell that is highly customizable and provides a rich set of features.
brew install zsh
#oh-my-zsh is a popular framework for managing Zsh configurations.
brew install oh-my-zsh
#zsh-syntax-highlighting is a plugin for zsh that adds syntax highlighting to the command line.
brew install zsh-syntax-highlighting
#zsh-autosuggestions is a plugin for zsh that adds autosuggestions to the command line.
brew install zsh-autosuggestions
#zsh-completions is a plugin for zsh that adds completions to the command line.
brew install zsh-completions

#Install browsers
brew install google-chrome
brew install firefox

#Install chat tools
brew install slack
brew install zoom

#Install productivity tools
brew install 1password
brew install 1password-cli

#Remove outdated versions from the cellar.
brew cleanup
