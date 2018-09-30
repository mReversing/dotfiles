export TERM=xterm-256color

declare TMUX
MOTD="$HOME/../usr/etc/motd"
MOTD2="$HOME/../usr/etc/motd-delete"
ISSUE="$HOME/../usr/etc/issue"

if [ ! -z "$TMUX" ]; then
	#在tmux内
	if [ -f "$MOTD" ]; then
		#cat "$MOTD"
		:
	elif [ -f "$ISSUE" ]; then
		#cat "$ISSUE"
		:
	else
		:
	fi
else 
	#不在tmux内
	if [ -f "$MOTD2" ]; then
		cat "$MOTD2"
	fi
	echo "$(date '+%Y-%m-%d %T' | toilet -f term -F border --gay)"
fi

alias ll='ls -Al'
