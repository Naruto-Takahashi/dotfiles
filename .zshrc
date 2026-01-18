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

# WSL Display (Adjusted for Zsh syntax if needed, but standard shell should work)
export DISPLAY=$(/mnt/c/Windows/System32/ipconfig.exe | grep -A 4 "vEthernet (WSL)" | grep "IPv4" | awk '{print $NF}'):0

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Neovim Tutor Aliases
alias vimtutor1='nvim -c "Tutor ja/vim-01-beginner"'
alias vimtutor2='nvim -c "Tutor ja/vim-02-beginner"'

# Zenn Aliases
alias zp='npx zenn preview'
alias zn='npx zenn new:article'

# PATH
export PATH="$PATH:/home/nalt/.local/bin"

# WezTerm OSC 7 support for Zsh
if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
  function wezterm_osc7 {
    printf "\033]7;file://%s%s\033\\" "$HOSTNAME" "$PWD"
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd wezterm_osc7
fi
