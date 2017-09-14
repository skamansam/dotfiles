#!/usr/bin/env bash

# Load RVM, if you are using it

# Add rvm gems and nginx to the path
#export PATH=$PATH:~/.gem/ruby/1.8/bin:/opt/nginx/sbin

# Path to the bash it configuration
export BASH_IT=$HOME/.bash_it

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='bobby'

# Your place for hosting Git repos. I use this for private repos.
#export GIT_HOSTING='git@git.domain.com'

# Set my editor and git editor
export EDITOR="/usr/bin/gedit"
export GIT_EDITOR='/usr/bin/gedit'

# Set the path nginx
#export NGINX_PATH='/opt/nginx'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
#export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
#export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/xvzf/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# Load Bash It
#source $BASH_IT/bash_it.sh

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


# User specific aliases and functions
export PATH=$HOME/.rvm/bin:$HOME/xsb/XSB/bin:$PATH # Add RVM to PATH for scripting

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="/home/sam/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
eval $(thefuck --alias)

[[ -s "/home/sam/.gvm/scripts/gvm" ]] && source "/home/sam/.gvm/scripts/gvm"
