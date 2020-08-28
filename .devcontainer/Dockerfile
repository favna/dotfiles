ARG VARIANT=14
FROM mcr.microsoft.com/vscode/devcontainers/typescript-node:${VARIANT}

# Add contrib and non-free repos to sources
RUN sed 's/stretch main/stretch main contrib non-free/g' -i /etc/apt/sources.list

# Install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
	&& apt-get -y install \
	build-essential \
	curl \
	fonts-firacode \
	htop \
	# region: node-canvas deps
	libcairo2-dev \
	libgif-dev \
	libjpeg-dev \
	libpango1.0-dev \
	librsvg2-dev \
	# end-region
	nano \
	neofetch \
	tree \ 
	vim \
	wget \
	zsh

# Download GitHub CLI v0.11.1 and put it in /usr/local/bin
RUN curl -sL https://github.com/cli/cli/releases/download/v0.11.1/gh_0.11.1_linux_amd64.tar.gz | tar -xz --wildcards "*gh" && mv gh*linux_amd64/bin/gh . && rm -r gh_*linux_amd64 \
	&& mv ./gh /usr/local/bin \
	&& chmod +x /usr/local/bin/gh

# Install typescript. eslint is installed by javascript image
ARG USERNAME=node
RUN sudo -u ${USERNAME} npm install -g typescript

ENV ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# Install Node 12 as additional version of node using nvm
# ARG EXTRA_NODE_VERSION=12
# RUN su node -c "source /usr/local/share/nvm/nvm.sh && nvm install ${EXTRA_NODE_VERSION} && nvm alias default 14 && nvm use 14"

# [Optional] Uncomment if you want to install more global node packages
RUN sudo -u node npm install -g \
	all-contributors-cli \
	commitizen \
	eslint \
	git-open \
	http-server \
	jest \
	lint-staged \
	node-gyp \
	pm2 \
	prettier \
	rimraf \
	rollup \
	standard-version \
	ts-node

# Install oh-my-zsh
RUN sudo -u node "git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh && git clone https://github.com/favware/zsh-git-enhanced.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-git-enhanced --depth 1 && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting --depth 1 && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions --depth 1"

# Install Meslo NGF Font
RUN sudo -u node "mkdir $HOME/.fonts && curl -sLo $HOME/.fonts/MesloLGS\ NF\ Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf && curl -sLo $HOME/.fonts/MesloLGS\ NF\ Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf &&  curl -sLo $HOME/.fonts/MesloLGS\ NF\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf && curl -sLo $HOME/.fonts/MesloLGS\ NF\ Bold\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"