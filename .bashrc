#
# ~/.bashrc: executed by bash(1) for non-login shells.
#

# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# another attempt at not doing anything if not running interactively
[ -z "$PS1" ] && return

# source system wide bash settings
if [ -f "/etc/bashrc" ] ; then
    . /etc/bashrc
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

# default prompt
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# if this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and grep via aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# source system wide bash completions
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# not sure if this is necessary as /etc/bash_completion may have already sourced that...
if [ -f /usr/share/bash-completion/bash_completion ] && ! shopt -oq posix; then
    . /usr/share/bash-completion/bash_completion
fi

# timeout bash after N seconds if current user is root
if [ $(id -u) = 0 ] ; then 
    export TMOUT=120
fi

# settings for local or remote logins
if [ -z "$SSH_CLIENT" ]; then
    # code when local login
else
    # code when remote login
fi

# source function definitions
if [ -d "~/.bash" ]; then
    . ~/.bash/options.sh
    . ~/.bash/history.sh
    . ~/.bash/environment.sh
    . ~/.bash/functions.sh
    . ~/.bash/git.sh
else
    printf '~/.bash/ directory not found. Not sourcing any files.\n'
fi

# source alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
else
    printf '~/.bash_aliases not found. Not sourcing alias definitions.\n'
fi

