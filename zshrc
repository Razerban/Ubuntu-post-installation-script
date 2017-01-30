# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/ahmed/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git command-not-found common-aliases cpv gnu-utils history history-substring-serach npm pep8 pip pyenv pylint python systemd virtualenv zsh_reaload z zsh-navigation-tools)

source $ZSH/oh-my-zsh.sh

# User configuration
DEFAULT_USER=$(whoami)

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='nano'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# USEFUL ALIASES START
alias zshconfig="nano ~/.zshrc"
alias ohmyzsh="nano ~/.oh-my-zsh"
alias system_update="sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y"
alias system_clean="sudo apt -f install -y && sudo apt-get -y autoremove && sudo apt-get -y autoclean && sudo apt-get -y clean"
alias update="system_update && brew update && update_anaconda && update_gems && update_npm && tldr -u"
alias clean="system_clean && brew cleanup && clean_anaconda && clean_gems && clean_npm"
# USEFUL ALIASES END

# JAVA VARIABLES START
export JAVA_HOME=$(dirname $(dirname $(readlink -e /usr/bin/javac)))
# JAVA VARIABLES END

# Configure LinuxBrew
export PATH=$HOME/.linuxbrew/bin:$PATH
export MANPATH=$HOME/.linuxbrew/share/man:$MANPATH
export INFOPATH=$HOME/.linuxbrew/share/info:$INFOPATH
# END Configure LinuxBrew

# PYTHON VARIABLES START
export ANACONDA2=$HOME/.anaconda/2
export ANACONDA3=$HOME/.anaconda/3
export PYTHONPATH=$ANACONDA2:$PYTHONPATH$
export PYTHONUSERBASE=$ANACONDA2
export PATH=$ANACONDA3/bin:$PATH
export PATH=$ANACONDA2/bin:$PATH
# PYTHON VARIABLES END

# PYTHON ALIASES START
alias update_anaconda2="$ANACONDA2/bin/conda update --all -y && $ANACONDA2/bin/pip freeze -l | awk  -F '==' '{ print $1 }' | xargs $ANACONDA2/bin/pip install -U"
alias update_anaconda3="$ANACONDA3/bin/conda update --all -y && $ANACONDA3/bin/pip freeze -l | awk  -F '==' '{ print $1 }' | xargs $ANACONDA3/bin/pip install -U"
alias clean_anaconda2="$ANACONDA2/bin/conda clean --all -y"
alias clean_anaconda3="$ANACONDA3/bin/conda clean --all -y"
alias update_anaconda="update_anaconda2 && update_anaconda3"
alias clean_anaconda="clean_anaconda2 && clean_anaconda3"
alias pip="$ANACONDA2/bin/pip"
alias pip2="pip"
alias pip3="$ANACONDA3/bin/pip"
# PYTHON ALIASES END

# RUBY ALIASES START
alias update_gems="sudo gem update --system && sudo gem update"
alias clean_gems="sudo gem cleanup -v"
# RUBY ALIASES STOP

# NPM ALIASES START
alias update_npm="sudo npm install npm -g && sudo npm update --save"
alias clean_npm="sudo npm cache clean"
# NPM ALIASES STOP

# Fixing brightness problem
# Usage : brightness PERCENTAGE_VALUE
function brightness() {
    MAX_VALUE=$(cat /sys/class/backlight/intel_backlight/max_brightness)
    WANTED_VALUE=$(echo "$1 * $MAX_VALUE / 100" | bc)
    sudo sh -c "echo $WANTED_VALUE > /sys/class/backlight/intel_backlight/brightness"
}

# Function to install python packages for Anaconda distributions
# Usage : pipinstall PACKAGE_NAMES
function pipinstall() {
    pip install $@
    pip3 install $@
}
