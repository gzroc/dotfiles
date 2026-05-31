# ============================================
# Oh My Zsh
# ============================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="jonathan"          # Starship 会覆盖，可保留作为备用
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ============================================
# Starship 提示符（接管 PS1）
# ============================================

eval "$(starship init zsh)"

# ============================================
# 环境变量
# ============================================

export RANGER_LOAD_DEFAULT_RC=false
export VDPAU_DRIVER=nvidia
export DRI_PRIME=0
# 使用 LANG 而不是 LC_ALL（更灵活）
export LANG="zh_CN.UTF-8"
export LC_CTYPE="zh_CN.UTF-8"
export EDITOR=nvim
export VISUAL=nvim

# ============================================
# PATH（只保留必要的）
# ============================================

export PATH="$HOME/.local/bin:$PATH"

# ============================================
# 别名（从 bashrc 迁移并优化）
# ============================================

# 基础 ls 增强
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CF'


# 工具启动
alias ra='ranger'
alias lg='lazygit'
alias ss='music-dl -k'

# 系统操作
alias pa='sudo pacman -S'
alias wgu='sudo wg-quick up wg0'
alias wgd='sudo wg-quick down wg0'

# 脚本快捷方式
alias bg='~/scripts/change_wallpaper.sh &'
alias rw='/home/ken/github/scripts/Remote_tuee.sh &'
alias tg='/home/ken/github/scripts/toggle-hifi.sh &'
alias th='/home/ken/github/scripts/toggle-hifi.sh &'
alias tp='/home/ken/github/scripts/tp.sh'
alias kr='killall rdesktop'
alias gw='~/scripts/getweather.sh'

# 截图（改名避免覆盖系统 cp）
alias shot='flameshot gui -p ~/Captures'
alias shotf='flameshot full -c -p ~/Captures'

alias c='xclip -selection clipboard'
# 按 Ctrl+y 把上一条命令重新执行并复制结果
bindkey -s '^y' '!! | xclip -selection clipboard\n'

# 
alias vim='nvim'
alias vi='nvim'

# ============================================
# 函数（优化原来的 vm 别名）
# ============================================

vm() {
    # 检查 music 会话是否存在
    if tmux has-session -t music 2>/dev/null; then
        tmux attach -t music
    else
        tmux new-session -s music "vimpc; exec $SHELL"
    fi
}

# ============================================
# 其他优化（可选）
# ============================================

# 历史命令去重
setopt HIST_IGNORE_ALL_DUPS

# 目录切换增强
setopt AUTO_CD

# yazi变更当前工作目录
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
export EDITOR=nvim
export VISUAL=nvim
