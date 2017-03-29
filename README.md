# conf
A repor for my conf archieves

# How to use
In your .bashrc, add
```bash
CONF_DIR=~/.gitbash
SSH_ENV=$HOME/.ssh/environment

# Aliases
source $CONF_DIR/.gitAliases
# Git complex functions
source $CONF_DIR/.gitFunctions.sh


# Alias propios
source $CONF_DIR/.myaliases
# Mis funciones 
source $CONF_DIR/.myFunctions.sh




# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
    ssh-add ~/.ssh/id_rsa
}
 
if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
    }
else
    start_agent;
fi
```
