# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source the standard profile for non-login shells
[[ -r /etc/profile ]] && source /etc/profile 2>/dev/null

# import keybindings for history search
[[ -r ~/.inputrc ]] && bind -f ~/.inputrc

# enviroment variables
PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH"
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
EDITOR=vim
PAGER=less
LESS='-Misc'
EXINIT='set number'
OSREL=`uname -s`

# export the variables to the os
export PATH HISTCONTROL HISTSIZE HISTFILESIZE
export EDITOR PAGER LESS EXINIT
export FTP_PASSIVE_MODE=true
case $OSREL in
  FreeBSD)
    export LANG='en_US.UTF-8'
    EDITOR=vi
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
    ;;
  Linux)
    export LANG='en_US.utf8'
    EDITOR=vim
    [[ -x /usr/bin/dircolors ]] && /usr/bin/dircolors >/dev/null
    [[ -x ~/.dircolors ]] && ~/.dircolors >/dev/null
    ;;
  Darwin)
    export TERM=xterm
    PATH="~/.rbenv/shims:~/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
    export LANG='en_US.utf8'
    export EDITOR="/usr/local/bin/subl -w"
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
    ;;
  *);;
esac

# Export the text editor Sublime
# ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

# file creation mask is 664
umask 002

# turn on interactive line editing
set -o emacs

# don't exit shell with ^D
set -o ignoreeof

# append to the history file, don't overwrite it
shopt -s histappend 2>/dev/null

# check the window size after each command
shopt -s checkwinsize 2>/dev/null

#check for background jobs before exiting a shell
shopt -s checkjobs 2>/dev/null

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

function git_branch {
  [[ -d .git ]] && [[ `git status 2>/dev/null` ]] && echo -n "{$(git status|head -n1|awk '{print $4}')}"
}

# Set the terminal title with `termname some title`
function tname { echo -en "\033]2;$*\007"; }

# save and load the history on every prompt
# show last exit code, time, user, hostname, directory, git branch, prompt
# color prompt for xterm

if [[ "$TERM" == 'xterm' ]] ; then
  PS1="$(history -a)$(history -n)(\t)\[\033[01;34m\]\u@\h\[\033[m\]:\[\033[0;32m\]\w/\[\033[m\]\[\033[0;36m\]\$(git_branch)\[\033[m\]\\$>"
else
  PS1="$(history -a)$(history -n)(\t)\u@\h:\w\\$>"
fi


# Color grep output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Ruby specific aliases
alias rspec="rspec --color --format nested"

# Misc. aliases
alias less='less -NMisc'
alias sudo='sudo '
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias cd..='cd ../'
alias ~='cd ~'
alias numfiles='echo $(ls -1 | wc -l)'

# OS dependent aliases
case $OSREL in
  FreeBSD)
    alias ls='ls -aCFG'
    alias ll='ls -alhFG -D"%F %T"'
    alias pp='ps axo user,pid,pcpu,pmem,stat,ni,time,command'
    alias netstat='netstat -anf inet'
  ;;
  Linux)
    alias ls='ls -aCF --color=auto'
    alias ll='ls -alhF --color=auto --time-style=long-iso'
    alias pp='ps axo user,pid,pcpu,pmem,stat,ni,bsdtime,command'
    alias netstat='netstat -ant'
  ;;
  Darwin)
    alias f='open -a Finder ./'
    alias ls='ls -aCF'
    alias ll='ls -alhF'
    alias pp='ps axo user,pid,pcpu,pmem,stat,ni,bsdtime,command'
    alias netstat='netstat -ant'
  ;;
  *)
    alias ls='ls -aCF'
    alias ll='ls -alhF'
    alias pp='ps aux'
    alias netstat='netstat -an'
  ;;
esac

# Alias definitions.
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
