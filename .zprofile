# Add Homebrew to PATH
export PATH="$PATH:/usr/local/bin"
# Add ~/bin to PATH
export PATH="$HOME/bin:$PATH";

# Load additional dotfiles and configurations
for file in ~/.{path,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
