#!/bin/bash
source $HOME/.bash_it/themes/colors.theme.bash
source $HOME/.bash_it/themes/base.theme.bash

SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓${normal}"
SCM_GIT_CHAR="${bold_green}±${normal}"
SCM_SVN_CHAR="${bold_cyan}⑆${normal}"
SCM_HG_CHAR="${bold_red}☿${normal}"

case $TERM in
	xterm*)
	TITLEBAR="\[\033]0;\w\007\]"
	;;
	*)
	TITLEBAR=""
	;;
esac

PS3=">> "

is_vim_shell() {
	if [ ! -z "$VIMRUNTIME" ]
	then
		echo "[${cyan}vim shell${normal}]"
	fi
}

modern_scm_prompt() {
	CHAR=$(scm_char)
	if [ $CHAR = $SCM_NONE_CHAR ]
	then
		return
	else
		echo "[$(scm_char)][${bold_blue}$(scm_prompt_info)${reset_color}]"
	fi
}

todo_count() {
  todocli | sed -e's/ *//' | wc -l
}

prompt() {
	if [ $? -ne 0 ]
	then
		# Yes, the indenting on these is weird, but it has to be like
		# this otherwise it won't display properly.
		#notify-send -u critical -i "/home/sam/.local/share/icons/Paper/symbolic/status/dialog-error-symbolic.svg" "$BASH_COMMAND has failed" "Command has finished and failed."
		PS1="${TITLEBAR}${bold_red}┌─[${reset_color}$(modern_scm_prompt)[${cyan}\W${normal}]$(is_vim_shell)
${bold_red}└─▪${normal} "
	else
		#notify-send -u normal -i "/home/sam/.local/share/icons/Paper/symbolic/status/dialog-information-symbolic.svg" "$BASH_COMMAND has finished" "Command has finished and succeeded."
		PS1="${TITLEBAR}┌─[$(modern_scm_prompt)[${cyan}\W${normal}]$(is_vim_shell)
└─▪ "
	fi
}

PS2="└─▪ "



PROMPT_COMMAND=prompt
