# .bashrc is sourced for an interactive shell.

#echo .bashrc

# For some reason, openssh invokes bash as an interactive shell even if we
# are only using scp. Therefore check that we have a terminal before processing
# this file
if test -n "$SSH_CONNECTION"; then
    tty -s || return
fi

# disable XON/XOFF so that we can use readline's forward-search-history command
# by pressing C-s
command -v stty &>/dev/null && stty ixon

shopt -s cdspell
#shopt -s failglob
shopt -s histverify
shopt -s no_empty_cmd_completion
shopt -s extglob

export DJANGO_COLORS="light"

export GREP_OPTIONS='--color=auto'

if test -n "$DISPLAY"
then
	BROWSER=gnome-open
else
	BROWSER=w3m
fi
export BROWSER

export PAGER=less
#export LESS='-icRFS'
command -v lesspipe &>/dev/null && eval "$(lesspipe)"
# see termcap(5) for an explanation of these codes
#export LESS_TERMCAP_mb='\033[01;31m' # start blink
export LESS_TERMCAP_md=$'\E[0;31m' # start bold
export LESS_TERMCAP_me=$'\E[0m' # back to normal
export LESS_TERMCAP_so=$'\E[0;44;33m' # start standout (status line)
export LESS_TERMCAP_se=$'\E[0m' # end standout
export LESS_TERMCAP_us=$'\E[0;32m' # start underline
export LESS_TERMCAP_ue=$'\E[0m' # end underline

command -v dircolors >/dev/null && eval "$(dircolors -b)"

if test -f /etc/bash_completion.d/git; then
	source /etc/bash_completion.d/git
elif test -f /opt/local/share/doc/git-core/contrib/completion/git-completion.bash; then
	source /opt/local/share/doc/git-core/contrib/completion/git-completion.bash
elif test -f /usr/local/git/contrib/completion/git-completion.bash; then
	# Darwin only?
	source /usr/local/git/contrib/completion/git-completion.bash
	source /usr/local/git/contrib/completion/git-prompt.sh
elif test -f /usr/local/etc/bash_completion.d/git-completion.bash; then
	source /usr/local/etc/bash_completion.d/git-completion.bash
	source /usr/local/etc/bash_completion.d/git-prompt.sh
fi

# django bash completion
if test -f /$HOME/.django_bash_completion.sh; then
	source $HOME/.django_bash_completion.sh
fi


HISTCONTROL=ignoreboth
HISTSIZE=5000

# xterm/screen title
#
case "$TERM" in
xterm*|rxvt*|screen)
	# http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
	PROMPT_COMMAND='printf "\033]0;${HOSTNAME%%.*}:${PWD/#$HOME/~}\a"'
	;;
esac

function gvimcpp {
	gvim $1.cpp "+new $1.h"
}

function physize {
	echo $(( $(stat -c '%B * %b' "$1") / 1024 )) "$1"
}

case $- in
*i*)
	source ~/.bash_aliases
	source ~/.alias_completions
	;;
esac

command -v gvfs-open &>/dev/null && alias open=gvfs-open

if test -z "$CLICOLOR"; then
	alias cgrep='grep --color --context=9999999'
	alias ls='ls --color=auto'
fi

# settings for mono
# export LD_LIBRARY_PATH=/opt/mono/lib
# export PKG_CONFIG_PATH=/opt/mono/lib/pkgconfig:/usr/lib64/pkgconfig

# export GOPATH=~/src
# export PATH=$PATH:$GOPATH/bin
# export PATH="/Users/jwhitmarsh/Library/Android/sdk/platform-tools/":$PATH

NPM_PACKAGES=/Users/sip/.npm-packages
PATH="$NPM_PACKAGES/bin:$PATH"

unset MANPATH
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

LTS="$(n --lts)"
CURRENT="$(node -v)"
GREEN='\033[01;32m'
RED='\033[01;31m'
NONE='\033[00m'

if [ $LTS = ${CURRENT/v/} ]; then
	echo -e "${GREEN}node is up to date with LTS: $LTS. go team!"
else
	echo -e "${RED}node is behind LTS. please update to $LTS"
	echo ""
    echo -e "   ${NONE}sudo n $LTS"
fi

eval "$(fasd --init auto)"

export LAMP_DEPLOYMENT_KEY=~/.ssh/drg-euw1-cider-development.pem

# Allows space to complete and expand !$ eg:
# $ ls Projects
# $ cd !$<space> # completes to `cd Projects`
bind Space:magic-space

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Useful timestamp format
HISTTIMEFORMAT='%F %T '

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH=".:~:~/src"

# This is for git to use the latest version installed from brew
export PATH=/usr/local/bin:$PATH

# This is to add adb and android to the path
export JAVA_HOME=`/usr/libexec/java_home`
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

export CIRCLE_TEST_REPORTS=/tmp/

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

eval "$(direnv hook bash)"

# Only load Liquid Prompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && source ~/src/liquidprompt/liquidprompt
