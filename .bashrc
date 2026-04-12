#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lha --color=auto'
alias l='ls -CF --color=auto'

# Launch ComfyUI Client
alias comfyui='chromium --app=http://0.0.0.0:8188 --incognito'

# Alias para monitorear recursos de IA (RAM + AMD GPU)
alias monitor="watch -c -n 5 'echo \"--- SISTEMA RAM ---\"; free -h; echo \"\"; echo \"--- GPU AMD (ROCm) ---\"; rocm-smi --showuse --showmemuse --showtemp'"

# Directorios amarillos, archivos normales, ejecutables verdes
export LS_COLORS='di=1;33:ln=36:so=35:pi=35:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=34;42'

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

shopt -s histappend
shopt -s histverify
export HISTCONTROL=ignoreboth

# Default command line prompt.
PROMPT_DIRTRIM=2
#PS1='\n\[\e[90m\]┌\[\e[90m\][\[\e[31m\]\d\[\e[0m\] \[\e[31m\]\t\[\e[90m\]]\[\e[90m\][\[\e[94m\]\w\[\e[90m\]]\n\[\e[90m\]└\[\e[90m\][\[\e[0m\]\u\[\e[97;1m\]@\[\e[0m\]\h\[\e[90m\]]\[\e[0m\] \[\e[1m\]\$\[\e[0m\] '
#PS1='\n\[\e[90m\]┌\[\e[90m\][\[\e[31m\]\d\[\e[0m\] \[\e[31m\]\t\[\e[90m\]]\[\e[90m\][\[\e[93m\]\w\[\e[90m\]]\n\[\e[90m\]└\[\e[90m\][\[\e[0m\]\u\[\e[97;1m\]@\[\e[0m\]\h\[\e[90m\]]\[\e[0m\] \[\e[1m\]\$\[\e[0m\] '
PS1='\n\[\e[90m\]┌\[\e[90m\][\[\e[31m\]\d\[\e[0m\] \[\e[31m\]\t\[\e[90m\]]\[\e[90m\][\[\e[38;5;220m\]\w\[\e[90m\]]\n\[\e[90m\]└\[\e[90m\][\[\e[0m\]\u\[\e[97;1m\]@\[\e[0m\]\h\[\e[90m\]]\[\e[0m\] \[\e[1m\]\$\[\e[0m\] '
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

export PYENV_ROOT="$HOME/.pyenv/"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

export LANG=es_ES.UTF-8
export LC_TIME=es_ES.UTF-8
export LC_ALL=es_ES.UTF-8
export GTK_THEME=Adwaita:dark

echo -ne '\e[5 q'
export HF_HOME=/mnt/sdb1/.cache/huggingface
export HF_HOME=/mnt/sdb1/.cache/huggingface
export HF_ENDPOINT=https://hf-mirror.com
export UV_CACHE_DIR=/mnt/sdb1/.cache/uv
export PATH=$PATH:/opt/rocm/bin
export PYTHONPATH=$PYTHONPATH:/opt/rocm/lib

# Previsualización de imágenes/archivos
export NNN_PREVIEWDIR="/tmp/nnn/previews"
export NNN_PAGER="less -R"

# Plugins (esencial para potencia)
export NNN_PLUG='c:chksum;f:finder;o:fzopen;p:preview-tui;t:tree;v:imgview'

# Orden y opciones
export NNN_OPTS="deHr"  # d = detalles, a = auto-sel, D = dimenas
export NNN_OPENER="xdg-open"  # Abrir archivos con app por defecto
export NNN_BMS="d:~/Documents;D:~/Downloads;p:~/Programas"  # Marcadores
export NNN_OPENER="xdg-open"

# Colores personalizados
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'

