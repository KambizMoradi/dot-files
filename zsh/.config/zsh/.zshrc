append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}


directory_to_add=~/.bin
if [ -d $directory_to_add ]
then
	append_path $directory_to_add
	export PATH
fi
unset -f append_path

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# p10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $XDG_CONFIG_HOME/zsh/.p10k.zsh ]] || source $XDG_CONFIG_HOME/zsh/.p10k.zsh

export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=True

# syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

##############################################################################
# History Configuration
##############################################################################
export HISTSIZE=100000              #How many lines of history to keep in memory
export SAVEHIST=1000000               #Number of history entries to save to disk
# export HISTTIMEFORMAT="[%F %T] "

setopt INC_APPEND_HISTORY			# Immediate append
# setopt EXTENDED_HISTORY				# Add Timestamp to history
setopt HIST_FIND_NO_DUPS			# Handling duplicate commands
setopt HIST_IGNORE_ALL_DUPS			# Handling duplicate commands
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

##############################################################################
# keybind
##############################################################################
bindkey -e
bindkey "^F" forward-word
bindkey "^B" backward-word

##############################################################################
# auto-completion
##############################################################################
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

##############################################################################
# zoxide
##############################################################################
eval "$(zoxide init zsh)"

##############################################################################
# Aliases
##############################################################################
function ca {
    clear -x
    echo -e -n $(date +"%F")" =======================================================\n"
    cal -3 -m
    echo -e "\n"
    echo -e -n $(jdate +"%F")" =======================================================\n"
    jcal -3

    echo -e -n "Word Wide Time ===================================================\n"
	echo -e -n "Australia/Melbourne:   ";TZ=Australia/Melbourne date "+%a %Y-%m-%d %H:%M:%S"
	echo -e -n "Iran/Tehran:           ";TZ=Asia/Tehran date "+%a %Y-%m-%d %H:%M:%S"
	echo -e -n "Canada/Montreal:       ";TZ=America/Montreal date "+%a %Y-%m-%d %H:%M:%S"
}

function npfu {
	sudo pacman -Sy
	packages=$(pacman -Qu|wc -l);
	clear -x
	echo packages for update: $packages
}

function cpu_set_frequency {
	echo set spu frequency to $1 ...
	sudo cpupower frequency-set --freq $1
	cpupower frequency-info --freq
}

alias ..='cd ..'
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l --human-readable --time-style="+%F %T %:z"'
alias grep='grep --color=auto'

alias ranger='ranger --choosedir=$HOME/.cache/ranger/.rangerdir; LASTDIR=`cat $HOME/.cache/ranger/.rangerdir`; cd "$LASTDIR";'
alias vimconfig='vim ~/.config/nvim/init.vim'
alias tree='tree -C'
alias neofetch='clear -x;neofetch --cpu_temp C'

alias cpu_high='cpu_set_frequency 4600000'
alias cpu_mid='cpu_set_frequency 2900000'
alias cpu_low='cpu_set_frequency 2800000'

alias remove='sudo pacman -Rcns'
alias resume='cd ~/Documents/Repositories/CV/DevOps;exa --all --long --header --icons --git'

alias shekan='cat /etc/resolv.conf;echo "============";sudo cp /etc/resolv.conf_shekan /etc/resolv.conf;cat /etc/resolv.conf'
alias shekan2='cat /etc/resolv.conf;echo "============";sudo cp /etc/resolv.conf_shekan2 /etc/resolv.conf;cat /etc/resolv.conf'
alias nashkan='cat /etc/resolv.conf;echo "============";sudo cp /etc/resolv.conf_router /etc/resolv.conf;cat /etc/resolv.conf'

alias docker-clean='echo "==========before:" ;\
					docker images ;\
					echo "----------" ;\
					docker system df ;\
					echo "===============" ;\
					docker image prune --all --force ;\
					docker system prune --force;\
					echo "==========after:" ;\
					docker images ;\
					echo "----------" ;\
					docker system df'
alias k="kubectl"
alias zr="zi ; ranger"
alias zi="zi && exa --all --long --header --icons --git"
alias zv="clear && zi && echo '================' && vared -p 'Open nvim?' -c tmp && nvim"

# hledger aliases
alias h="hledger"
alias hi="hledger-iadd"

# navi
alias navi='navi --print'
alias navi-tldr='navi --tldr'
alias navi-cheatsh='navi --cheatsh'


# taskwarrior aliases
source ~/.config/task/taskrc_aliases.sh
