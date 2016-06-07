# .bash_profile is sourced for a login shell.
# my .xsessionrc sources it, so place in here 'session' type configuration.
# 
# <http://lists.gnu.org/archive/html/bug-bash/2005-01/msg00263.html> is a good
# explanation of this insanity. Also <http://lkml.org/lkml/2005/4/25/205>.

export PATH=$PATH:$HOME/bin

export PATH=$PATH:$HOME/.rvm/scripts/rvm

source "$HOME/.rvm/scripts/rvm"

test -f ~/.pythonrc && export PYTHONSTARTUP=$HOME/.pythonrc

case "$(uname -s)" in
Linux)
	# Received wisdom from Cygwin's default .bashrc
	unset TMP
	unset TEMP
	# MacPorts Installer addition on 2015-03-11_at_12:26:02: adding an appropriate PATH variable for use with MacPorts.
	export PATH="/opt/local/bin:/opt/local/sbin:/home/ec2-user/src/keychain-2.8.1/:$PATH"
	# Finished adapting your PATH environment variable for use with MacPorts.

	eval `keychain --eval --agents ssh id_rsa`
	;;
Darwin)
	export CLICOLOR=1
	;;
esac

# Source .bashrc if this is an interactive shell
case $- in
*i*)
	source ~/.bashrc
	;;
esac


function zipCurrentFolder()
{
	zip -r ${PWD##*/}.zip *;
}

function ggl()
{
	open http://google.co.uk/search?q="$1"
}

##
# Your previous /Users/jwhitmarsh/.bash_profile file was backed up as /Users/jwhitmarsh/.bash_profile.macports-saved_2015-03-11_at_12:26:02
##

export GOPATH=$HOME/work
export PATH=$GOPATH/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# iTerm2 tab titles
function title {
    if [ "$1" ]
    then
        export PROMPT_COMMAND='iterm2_preexec_invoke_cmd'
        echo -ne "\033]0;${*}\007"
    else
        export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007";iterm2_preexec_invoke_cmd'
    fi
}
title

# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH
