alias l="eza -l --icons=always"
alias ls="eza -g --icons=always"
alias lt="eza -T --icons=always"
if status is-interactive
  starship init fish | source
  fastfetch
end
