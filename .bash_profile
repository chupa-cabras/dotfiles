source /usr/local/opt/asdf/asdf.sh

#-------------------------------------------------
#  Colorful Terminal
#-------------------------------------------------
#
# Colorindo o ls e o grep
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="4;33"
export CLICOLOR="auto"


function parse_git_branch () {
       git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOUR="\[\033[0m\]"

PS1="$GREEN\u@\h$NO_COLOUR:\w$YELLOW\$(parse_git_branch)$NO_COLOUR\$ "
# ENVIRONMENT VARIABLES


# set EDITOR to bbedit
if [[ -e "/usr/local/bin/bbedit" ]]; then
    export EDITOR="bbedit -w --resume"
fi

# ALIASES

alias ll='ls -l'
alias lll='ls -alhTOe@'
alias ls='ls -l'

# save me from myself
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

alias ..="cd .."
alias ...="cd ../.."
alias cd..="cd .."

# Ring the terminal bell, and badge Terminal's icon
alias badge="tput bel"

# insert an empty space in the Dock
alias dockspace="defaults write com.apple.dock persistent-apps -array-add '{\"tile-type\"=\"spacer-tile\";}'; killall Dock;"

alias reveal='open -R'
alias xcode='open -a Xcode'
alias pacifist='open -a Pacifist'

alias be='bundle exec'
alias pgstart='pg_ctl -D /usr/local/var/postgres start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop'

# FUNCTIONS

# man commands
# http://scriptingosx.com/2017/04/on-viewing-man-pages/

function preman() {
	man -t $@ | open -f -a "Preview"
}

function xmanpage() {
	open x-man-page://$@
}

function bbman () {
  MANWIDTH=80 MANPAGER='col -bx' man $@ | bbedit --clean --view-top -t "man $@"
}

# prints the path of the front Finder window. Desktop if no window open
# http://scriptingosx.com/2017/02/terminal-finder-interaction/
function pwdf () {
	osascript <<EOS
		tell application "Finder"
			if (count of Finder windows) is 0 then
				set dir to (desktop as alias)
			else
				set dir to ((target of Finder window 1) as alias)
			end if
			return POSIX path of dir
		end tell
EOS
}

# changes directory to frontmost 
alias cdf='pwdf; cd "$(pwdf)"'