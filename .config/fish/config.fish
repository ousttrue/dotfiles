if test -x exa
    alias e 'exa --icons'
    alias l e
    alias ls e
    alias ea 'exa -a --icons'
    alias la ea
    alias ee 'exa -aal --icons'
    alias ll ee
    alias et 'exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
    alias lt et
    alias eta 'exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
    alias lta eta
end

# starship init fish | source

