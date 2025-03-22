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
source $XDG_DATA_HOME/myalias.env

