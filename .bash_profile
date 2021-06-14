if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export EDITOR=vim

####################################################################
# System settings
####################################################################
alias ls='ls -G'

# Git aliases
alias gitpatch='git format-patch --unified=500'

# Create core dump file
ulimit -c unlimited

# Share history between all bash'es
export HISTSIZE=
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignorespace:ignoredups:erasedups
export HISTTIMEFORMAT="[%F %T] "

history() {
  _bash_history_sync
  builtin history "$@"
}

_bash_history_sync() {
  builtin history -a         #1
  HISTFILESIZE=$HISTFILESIZE #2
  builtin history -c         #3
  builtin history -r         #4
}

PROMPT_COMMAND=_bash_history_sync

# from https://gist.github.com/616341
source ~/.git-prompt.sh

function parse_git_branch_and_add_brackets {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}
#PS1="\u@\h:\w \[\033[0;32m\]\$(parse_git_branch_and_add_brackets) \[\033[0m\]\$ "

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
PS1='\u@\h:\w\[\033[0;32m\]$(__git_ps1 " [%s]")\[\033[0m\]\$ '

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

if which jenv > /dev/null; then eval "$(jenv init -)"; fi

#export JAVA_HOME=`/usr/libexec/java_home`

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


export PIP_REQUIRE_VIRTUALENV=false

gpip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# rbenv
eval "$(rbenv init -)"

# pyenv
eval "$(pyenv init -)"

# jenv
eval "$(jenv init -)"

# fuzzy search fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# jfrog cli
[ -f ~/.jfrog/jfrog_bash_completion ] && source ~/.jfrog/jfrog_bash_completion
