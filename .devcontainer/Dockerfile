ARG VARIANT=14
FROM mcr.microsoft.com/vscode/devcontainers/typescript-node:${VARIANT}

RUN echo ">>>>>>>>>>========================<<<<<<<<<<<<<<<" \
	&& ls -al /etc/apt \ 
	&& echo ">>>>>>>>>>========================<<<<<<<<<<<<<<<" \
	&&  cat /etc/apt/sources.list \
	&& echo ">>>>>>>>>>========================<<<<<<<<<<<<<<<"

RUN sed 's/buster main/busted main contrib non-free/g' -i /etc/apt/sources.list

# Install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
	&& apt-get -y install \
	build-essential \
	curl \
	fonts-firacode \
	htop \
	libcairo2-dev \
	libgif-dev \
	libjpeg-dev \
	libpango1.0-dev \
	librsvg2-dev \
	nano \
	neofetch \
	software-properties-common \
	tree \ 
	vim \
	wget \
	zsh

# Download latest GitHub CLI version and put it in /usr/local/bin
RUN curl -sL \
	$(curl -sL \
	-H "Authorization: bearer ${GITHUB_TOKEN}" \
	-X POST \
	--data '{"query":"query { repository(owner: \"cli\", name: \"cli\") { releases(last: 1) { nodes { releaseAssets(first: 20) { nodes { downloadUrl name }}}}}}"}' "https://api.github.com/graphql" | jq -cr '.data.repository.releases.nodes[0].releaseAssets.nodes[]? | select(.name | contains("linux_amd64.tar.gz")).downloadUrl') | tar -xz --wildcards "*gh" && mv gh*linux_amd64/bin/gh . && rm -r gh_*linux_amd64 \
	&& mv ./gh /usr/local/bin \
	&& chmod +x /usr/local/bin/gh

# Install typescript. eslint is installed by javascript image
ARG USERNAME=node
RUN sudo -u ${USERNAME} npm install -g typescript

ENV ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# Install Node 12 as additional version of node using nvm
ARG EXTRA_NODE_VERSION=12
RUN su node -c "source /usr/local/share/nvm/nvm.sh && nvm install ${EXTRA_NODE_VERSION}"

# [Optional] Uncomment if you want to install more global node packages
RUN sudo -u node npm install -g \
	all-contributors \
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