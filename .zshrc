# =============================================================================
# Environment Variables
# =============================================================================
export PATH="$HOME/.local/bin:$HOME/.fzf/bin:$PATH"
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/home/nalt/lib/ac-library-master
ulimit -s unlimited

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Rust / Cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# =============================================================================
# History
# =============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicate entries
setopt HIST_IGNORE_SPACE      # Don't save commands starting with space
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks

# =============================================================================
# Completion
# =============================================================================
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case insensitive
zstyle ':completion:*' menu select                  # Select with cursor

# =============================================================================
# Tool Initialization
# =============================================================================
# Starship
eval "$(starship init zsh)"

# zsh-syntax-highlighting
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# zsh-autosuggestions
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# fzf
if [ -d ~/.fzf ]; then
    source ~/.fzf/shell/completion.zsh 2> /dev/null
    source ~/.fzf/shell/key-bindings.zsh
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
    export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview,tab:down,btab:up'"
fi

# zoxide (better cd)
if command -v zoxide >/dev/null; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

# =============================================================================
# Aliases
# =============================================================================
# Utility
alias c='clear'
alias reload='source ~/.zshrc && echo "Sourced .zshrc"'
alias path='echo $PATH | tr ":" "\n"'

# Safety & Verbosity
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# System
alias df='df -h'
alias free='free -h'

# Git
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gs='git status'

# Vim
alias vim='nvim'

# ls / eza
if command -v eza >/dev/null; then
    alias ls='eza --icons --git'
    alias ll='eza -alF --icons --git'
    alias la='eza -a --icons --git'
    alias l='eza -F --icons --git'
    alias tree='eza --tree --icons'
else
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
fi

# grep
alias grep='grep --color=auto'

# bat (better cat)
if command -v bat >/dev/null; then
    alias cat='bat'
fi

# fd (alternative to find)
if command -v fdfind >/dev/null; then
    alias fd='fdfind'
fi

# lazygit
if command -v lazygit >/dev/null; then
    alias lg='lazygit'
fi

# Neovim Tutor
alias vimtutor1='nvim -c "Tutor ja/vim-01-beginner"'
alias vimtutor2='nvim -c "Tutor ja/vim-02-beginner"'

# Zenn
alias zp='npx zenn preview'
alias zn='npx zenn new:article'
alias zqr='~/dotfiles/bash/zqr'
alias zstop='pkill ngrok && echo "ngrok stopped."'

# =============================================================================
# Functions
# =============================================================================
mkcd() {
    mkdir -p "$1"
    cd "$1" || return
}

# Auto ls after cd
function chpwd() {
    ls
}

runcpp() {
    g++ -std=c++20 -O2 "$1" -o "${1%.cpp}.out" && "./${1%.cpp}.out"
}

runcppio() {
    g++ -std=c++20 -O2 "$1" -o "${1%.cpp}.out" && "./${1%.cpp}.out" < input.txt > output.txt
}

# WezTerm OSC 7 support
if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
    wezterm_osc7() {
        printf "\033]7;file://%s%s\033\\" "$HOST" "$PWD"
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd wezterm_osc7
fi

# =============================================================================
# Local Settings
# =============================================================================
[ -f ~/.env ] && source ~/.env