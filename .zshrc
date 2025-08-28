eval "$(starship init zsh)"

# alias
alias ..="cd .."
alias ...="cd ../.."
alias ll="eza -l --icons=auto --git"
alias la="eza -l --icons=auto --git"
alias ls="eza -l --icons=auto --git"
alias ls0="eza --icons=auto -T -l --total-size --git -R --level=1"
alias ls1="eza --icons=auto -T -l --total-size --git -R --level=2"
alias ls2="eza --icons=auto -T -la --total-size --git -R --level=3"
alias ls3="eza --icons=auto -T -la --total-size --git -R --level=4"
alias tldrz="tldr -L zh"
alias vim="nvim"

#语法检查和高亮
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#开启tab上下左右选择补全
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit

# 设置历史记录文件的路径
HISTFILE=~/.zsh_history

# 设置在会话（内存）中和历史文件中保存的条数，建议设置得大一些
HISTSIZE=1000
SAVEHIST=1000

# 忽略重复的命令，连续输入多次的相同命令只记一次
setopt HIST_IGNORE_DUPS

# 忽略以空格开头的命令（用于临时执行一些你不想保存的敏感命令）
setopt HIST_IGNORE_SPACE

# 在多个终端之间实时共享历史记录 
# 这是实现多终端同步最关键的选项
setopt SHARE_HISTORY

# 让新的历史记录追加到文件，而不是覆盖
setopt APPEND_HISTORY
# 在历史记录中记录命令的执行开始时间和持续时间
setopt EXTENDED_HISTORY


# 代理设置函数 - 支持外部输入代理地址
proxy() {
    # 如果未提供参数，使用默认地址
    local proxy_addr=${1:-"http://127.0.0.1:7890"}
    local socks_addr=${proxy_addr/http:/socks5:}  # 自动转换为socks5地址
    
    # 设置HTTP/HTTPS代理
    export http_proxy="$proxy_addr"
    export https_proxy="$proxy_addr"
    
    # 设置socks5代理
    export all_proxy="$socks_addr"
    
    # Git代理设置
    git config --global http.proxy "$proxy_addr"
    git config --global https.proxy "$proxy_addr"
    
    echo "代理已启用"
    echo "HTTP代理: $http_proxy"
    echo "HTTPS代理: $https_proxy"
    echo "Socks5代理: $all_proxy"
}

# 取消代理设置函数
unproxy() {
    # 清除环境变量中的代理设置
    unset http_proxy
    unset https_proxy
    unset all_proxy
    
    # 清除Git的代理设置
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    
    echo "代理已关闭"
}

