#source .profile.d, just as /etc/profile does
for i in $HOME/.profile.d/*.sh ; do
    if [ -r "$i" ]; then
        if [ "${-#*i}" != "$-" ]; then 
            . "$i"
        else
            . "$i" >/dev/null 2>&1
        fi
    fi
done

#export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
