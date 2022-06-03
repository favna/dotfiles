export TERM="xterm-256color"
export VOLTA_HOME="$HOME/.volta"
export PATH="$PATH:$HOME/.local/bin:$VOLTA_HOME/bin"
export ZSH="$HOME/.oh-my-zsh"
export PROMPT_EOL_MARK=''

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_DISABLE_COMPFIX="true"

STREAMABLEUSER="username"
STREAMABLEPASSWORD="password"

plugins=(
  zsh-git-enhanced
#   zsh-autosuggestions
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

source $ZSH/oh-my-zsh.sh
source $HOME/.profile
source "$HOME/.cargo/env"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"

export PATH="$PATH:`yarn global bin`"
