alias dotui="gitui -d \$HOME/.cfg/ -w \$HOME"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Added by get-aspire-cli.sh
fish_add_path $HOME/.aspire/bin

zoxide init fish | source
