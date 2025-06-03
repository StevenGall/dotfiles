# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Load .zprofile if it exists and we're in an interactive shell
[[ -o interactive ]] && source ~/.zprofile

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="ys"

# Load additional configuration files
for file in ~/.{aliases,functions,exports,path,local-overrides}; do
    [[ -f "$file" ]] && source "$file"
done

# Load local overrides last (if they exist)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Which plugins would you like to load?
plugins=(
    git
    aws
    brew
    common-aliases
    httpie
    kubectl
    sbt
    scala
    sudo
    postgres
    jsontools
    docker
    docker-compose
    vscode
)

source $ZSH/oh-my-zsh.sh

# Load syntax highlighting (should be last)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null || true

# Load iTerm2 integration if it exists
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

