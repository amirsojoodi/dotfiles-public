# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

source ~/.git-prompt.sh

if [ "$color_prompt" = yes ]; then
  # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

###############################################################################
############################ Some more Aliases ################################
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias mkdir='mkdir -pv'
alias h='history'
alias histg="history | grep"
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias vi='vim'
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'
alias ports='netstat -tulanp'
alias su='sudo -i'
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'
alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'
alias wget='wget -c'
alias df="df -Tha --total"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias top="htop"
alias myip="curl http://ipecho.net/plain; echo"
alias DU="du --max-depth=1 -B M |sort -rn"
alias make="make -j4"
alias c="xclip"               # copy to X clipboard (register *)
alias cs="xclip -sel clip"    # copy to system wide clipboard (register +)
alias v="xclip -o"            # output copied content (paste)
alias vs="xclip -o -sel clip" # paste from system wide clipboard (equivalent to `v -selection clipboard`)

###############################################################################
############################ Tmux Aliases #####################################
# tmux aliases
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'
alias tls='tmux ls'
alias tn='tmux new -s'
alias ttop='tmux attach -t top || tmux new -s top "top"'
# managing ssh sessions to remote servers
# First check if the session exists, if not create a new one and ssh to the server
# You can then later split the window and do whatever you want with the session, then detach and reattach later
alias tpprl='tmux attach -t pprl || tmux new -s pprl "ssh pprl"'
alias tmist='tmux attach -t mist || tmux new -s mist "ssh mist"'
alias tnarval='tmux attach -t narval || tmux new -s narval "ssh narval"'
alias tbeluga='tmux attach -t beluga || tmux new -s beluga "ssh beluga"'
alias tgraham='tmux attach -t graham || tmux new -s graham "ssh graham"'
# List and Kill all 2FA ssh connections
alias ls2fa="ps aux | grep ssh | grep mux"
alias kill2fa="kill -9 $(ps aux | grep ssh | grep mux | awk '{print $2}' | xargs)"

###############################################################################
############################ Alias definitions ################################
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

###############################################################################
############################ Bash completion ##################################
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###############################################################################
############################ Loading SSH Agent ################################
env=~/.ssh/agent.env
agent_load_env() { test -f "$env" && . "$env" >|/dev/null; }
agent_start() {
  (
    umask 077
    ssh-agent >|"$env"
  )
  . "$env" >|/dev/null
}
agent_load_env
# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(
  ssh-add -l >|/dev/null 2>&1
  echo $?
)
if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
  agent_start
  ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
  ssh-add
fi
unset env

###############################################################################
############################ CUDA Settings ####################################
export CUDA_HOME="/usr/local/cuda"
export PATH=$PATH:"$CUDA_HOME/bin"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$CUDA_HOME/lib64"

###############################################################################
############################ NVM Settings #####################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

###############################################################################
############################ Pyenv Settings ###################################
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

###############################################################################
############################# Emscripten ######################################
export EMSDK_QUIET=1
source "/home/amir/Documents/emsdk/emsdk_env.sh"

###############################################################################
############################ slurm Settings ####################################
alias nsys-profile="nsys profile --trace=cuda,mpi,ucx,nvtx --sample=cpu --mpi-impl=openmpi --backtrace=lbr --cudabacktrace=all --gpu-metrics-device=all --force-overwrite true"
alias mpirun-ucx="mpirun --mca pml ucx -x UCX_TLS=sm,cuda_copy,cuda_ipc --mca btl ^vader,tcp,openib --mca coll ^hcoll,ahscuda"
alias my-sbatch-report='sacct -aX -o jobid,jobname%36,NNodes,NCPUS,start,elapsed,state -u username'
alias sbatch-report='sacct -aX -o jobid,jobname%36,NNodes,NCPUS,start,elapsed,state'

###############################################################################
############################ Other Settings ###################################
## Vampir
export PATH=$PATH:"/home/amir/vampir-10.3.0/bin"
export PATH=$PATH:"/home/amir/Documents/SPIRV-LLVM-Translator/build/tools/llvm-spirv"

## Ruby
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

## Chrome with WebGPU
alias chrome="DISPLAY=:1 google-chrome-unstable --enable-unsafe-webgpu --enable-features=Vulkan --disable-dawn-features=disallow_unsafe_apis &"

###############################################################################
########################## Things to show at login ############################
# neofetch
fastfetch

echo "Available tmux sessions:" | lolcat
#figlet tmux sessions:
echo "========================" | lolcat
tmux ls | lolcat
