# XDG setting
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

# zsh setting
export HISTFILE="$XDG_STATE_HOME"/zsh/history

# set default editor
export EDITOR=/usr/bin/nvim;

# set default visual
export VISUAL=/usr/bin/nvim;

# FZF for fzf.vim
export FZF_DEFAULT_OPTS='--reverse'

# npm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# bat theme
# export BAT_THEME="TwoDark"

########################################################
# CLEAN HOME DIRECTORY
# pythonrc
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"

# wine
export WINEPREFIX="$XDG_DATA_HOME"/wine

# vagrant
export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant
export VAGRANT_DEFAULT_PROVIDER=libvirt

# pass
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass

# less
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

# julia
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"

# ipython
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"

# gnupg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine

# minikube
export MINIKUBE_HOME="$XDG_DATA_HOME"/minikube

# kubectl
export KUBECONFIG="$XDG_CONFIG_HOME/kube"
export KUBECACHEDIR="$XDG_CACHE_HOME/kube"

# ansible
export ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"

# zoxide
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
export _ZO_ECHO=0
export _ZO_EXCLUDE_DIRS="$HOME"
export _ZO_FZF_OPTS=""
export _ZO_MAXAGE=10000
export _ZO_RESOLVE_SYMLINKS=0

# hledger
export LEDGER_FILE="$HOME"/Documents/termux/.local/share/hledger.journal

# gtk theme
export GTK_THEME=Adwaita:dark

# texlive 
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config

#X11
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

