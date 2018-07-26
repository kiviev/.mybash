
# How to use
## Instalation
### Auto
Execute this command on your terminal (you must have curl installed)
```
curl https://raw.githubusercontent.com/kiviev/.mybash/master/autoinstall.sh | sh
```
### Manual
Clone this repo:
```
cd ~
git clone https://github.com/kiviev/.mybash.git
```

In your .bashrc, add:
```bash
CONF_DIR=~/.mybash
SSH_ENV=$HOME/.ssh/environment

source $CONF_DIR/init
```

