# .bash_profile is sourced for a login shell.
# my .xsessionrc sources it, so place in here 'session' type configuration.
#
# <http://lists.gnu.org/archive/html/bug-bash/2005-01/msg00263.html> is a good
# explanation of this insanity. Also <http://lkml.org/lkml/2005/4/25/205>.

export PATH=$PATH:$HOME/bin

export PATH=$PATH:$HOME/.rvm/scripts/rvm

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

export GOPATH=$HOME/work
export PATH=$GOPATH/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$HOME/.rvm/gems/ruby-2.3.0/bin:$PATH" # Add RVM gems verson to PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
