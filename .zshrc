export TERM="xterm-256color"
export ZSH="$HOME/.oh-my-zsh"

# Extending Path
export PATH="$PATH:$HOME/.local/bin:`yarn global bin`"

alias x="exit"

# Setting variables
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_DISABLE_COMPFIX="true"

STREAMABLEUSER="username"
STREAMABLEPASSWORD="password"

# Loading plugins
plugins=(
  zsh-git-enhanced
  zsh-autosuggestions
  zsh-syntax-highlighting
)

gitalias() {
    cat ~/.oh-my-zsh/custom/plugins/zsh-git-enhanced/zsh-git-enhanced.plugin.zsh | grep $1
}

streamupload() {
  code=$(curl --request POST --url https://api.streamable.com/upload --user $STREAMABLEUSER:$STREAMABLEPASSWORD --form file=@"$1" | jq -r '.shortcode');
  echo Added https://streamable.com/$code to your clipboard;
  echo https://streamable.com/$code | clip.exe;
}

# Sourcing dem files
source $HOME/.profile
source $ZSH/oh-my-zsh.sh

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

eval "$(starship init zsh)"
