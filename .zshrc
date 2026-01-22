# Starship init
eval "$(starship init zsh)"

# zsh-syntax-highlighting
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# --- Migrated from .bashrc ---

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Functions
mkcd() {
    mkdir -p "$1"
    cd "$1" || return
}

runcpp() {
    g++ -std=c++20 -O2 "$1" -o "${1%.cpp}.out" && "./${1%.cpp}.out"
}

runcppio() {
    g++ -std=c++20 -O2 "$1" -o "${1%.cpp}.out" && "./${1%.cpp}.out" < input.txt > output.txt
}

# Environment Variables
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/home/nalt/lib/ac-library-master
ulimit -s unlimited

# WSL Display
# export DISPLAY=$(/mnt/c/Windows/System32/ipconfig.exe | grep -A 4 "vEthernet (WSL)" | grep "IPv4" | awk '{print $NF}'):0

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Neovim Tutor Aliases
alias vimtutor1='nvim -c "Tutor ja/vim-01-beginner"'
alias vimtutor2='nvim -c "Tutor ja/vim-02-beginner"'

# Zenn Aliases
alias zp='npx zenn preview'
alias zn='npx zenn new:article'

# PATH
export PATH="$PATH:/home/nalt/.local/bin"

# WezTerm OSC 7 support
if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
    wezterm_osc7() {
        printf "\033]7;file://%s%s\033\\" "$HOST" "$PWD"
    }
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd wezterm_osc7
fi

. "$HOME/.cargo/env"

# --- Added by Gemini ---

# zsh-autosuggestions
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# fzf
if [ -d ~/.fzf ]; then
    export PATH="$PATH:$HOME/.fzf/bin"
    source ~/.fzf/shell/completion.zsh 2> /dev/null
    source ~/.fzf/shell/key-bindings.zsh
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi

# zoxide (better cd)
if command -v zoxide >/dev/null; then
    eval "$(zoxide init zsh)"
    alias cd='z'
fi

# eza (better ls)
if command -v eza >/dev/null; then
    alias ls='eza --icons --git'
    alias ll='eza -alF --icons --git'
    alias la='eza -a --icons --git'
    alias l='eza -F --icons --git'
    alias tree='eza --tree --icons'
fi

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

# Zenn Aliases
alias zp='npx zenn preview'
alias zn='npx zenn new:article'
alias zqr='~/dotfiles/bash/zqr'
alias zstop='pkill ngrok && echo "ngrok stopped."'
[ -f ~/.env ] && source ~/.env
