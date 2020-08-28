ARG VARIANT=14
FROM mcr.microsoft.com/vscode/devcontainers/typescript-node:${VARIANT}

# Install apt-transport-https
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
	&& apt-get -y install \
	apt-transport-https

# Import the Microsoft public repository GPG keys
RUN curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Register the Microsoft Product feed
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/microsoft.list

# Add contrib and non-free repos to sources
RUN sed 's/stretch main/stretch main contrib non-free/g' -i /etc/apt/sources.list

# Install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
	&& apt-get -y install \
	apt-transport-https \
	build-essential \
	curl \
	fonts-firacode \
	gnupg \
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
	powershell \
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