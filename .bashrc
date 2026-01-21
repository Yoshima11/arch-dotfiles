#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias lsa='ls -a'
alias lsal='ls -al'

alias grep='grep --color=auto'
# bun
export BUN_INSTALL="$HOME/.local/share/reflex/bun"
export PATH=$BUN_INSTALL/bin:$PATH

#android home
export ANDROID_HOME=/usr/lib/Android
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH

#android sdk root
export ANDROID_SDK_ROOT=/usr/lib/Android
export PATH=$ANDROID_SDK_ROOT:$PATH

#flutter
export FLUTTER_HOME=/usr/lib/flutter
export PATH=$FLUTTER_HOME/bin:$PATH

#gradle
export GRADLE_HOME=/opt/gradle/gradle-7.0.1
export PATH=$GRADLE_HOME/bin:$PATH

#rocm
export PATH=$PATH:/opt/rocm/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/rocm/lib

shopt -s histappend
shopt -s histverify
export HISTCONTROL=ignoreboth

# Default command line prompt.
PROMPT_DIRTRIM=2
PS1='\n\[\e[90m\]┌\[\e[90m\][\[\e[31m\]\d\[\e[0m\] \[\e[31m\]\t\[\e[90m\]]\[\e[90m\][\[\e[94m\]\w\[\e[90m\]]\n\[\e[90m\]└\[\e[90m\][\[\e[0m\]\u\[\e[97;1m\]@\[\e[0m\]\h\[\e[90m\]]\[\e[0m\] \[\e[1m\]\$\[\e[0m\] '
# Handles nonexistent commands.
# If user has entered command which invokes non-available
# utility, command-not-found will give a package suggestions.
if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
	command_not_found_handle() {
		/data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
	}
fi

[ -r /data/data/com.termux/files/usr/share/bash-completion/bash_completion ] && . /data/data/com.termux/files/usr/share/bash-completion/bash_completion


# Created by `pipx` on 2024-12-03 07:49:12
export PATH="$PATH:/home/eduardo/.local/bin"
export EDITOR="nvim"
export VISUAL="nvim"

export PYENV_ROOT="$HOME/.virtualenvs/"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/eduardo/.lmstudio/bin"
# End of LM Studio CLI section

export LANG=es_ES.UTF-8
export LC_TIME=es_ES.UTF-8
export LC_ALL=es_ES.UTF-8

echo -ne '\e[5 q'
