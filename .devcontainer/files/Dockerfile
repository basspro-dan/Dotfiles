FROM ubuntu:22.04


## Set TZ for the Ansible install
ENV TZ=America/Chicago
RUN apt-get update -y


RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Install prerequisites
RUN apt-get install -y  curl make build-essential git libssl-dev liblzma-dev libsqlite3-dev python3-pip libreadline6-dev libffi-dev libbz2-dev openssh-server sshpass rsync gnupg software-properties-common ansible ansible-lint parallel iproute2 vim tmux gawk jq unzip libsecret-1-0


## NOTE: ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## #
#                                                                    #
# All these services that are pulled remotely should, at some point, #
# be hosted locally in a sourece repo we control. Lest any one       #
# of these services go down or get removed for whatever reason.      #
#                                                                    #
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## #


# Install Azure CLI ( WIll need to supply keys later )
RUN curl -LsS https://aka.ms/InstallAzureCLIDeb | bash && rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# install Githubs GH CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list'
RUN apt-get update && apt-get install -y gh

# Install Pyenv, configure for the latest stable 3 version for now.
# RUN curl https://pyenv.run | bash ## Moved it to the dotfile. 


# Install TFswitch
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/master/install.sh | bash


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## #

WORKDIR /usr/local/bin
RUN wget https://github.com/akamai/cli/releases/download/v2.0.1/akamai-v2.0.1-linuxamd64 -O akamai
RUN chmod +x /usr/local/bin/akamai
RUN akamai install dns


# Return us to our home folder
WORKDIR /root


RUN exec $SHELL
## use this entry point to start without the SSH Daemon. 
# ENTRYPOINT [ "bash" ] 

# The following isn't the 'docker way' of calling the entry point. (ToFix)
#  https://docs.docker.com/reference/build-checks/json-args-recommended/
ENTRYPOINT service ssh restart && bash && cd /root



## Run with: 
#  docker run -i --volume ~/workdir:/root/Basspro --volume ~/.edgerc:/root/.edgerc:ro -t $(docker images -aq)

# Where /root/Basspro has 
# - your cloned respositories 
# - .edgerc has the contents of your akamai credentials. 
# - Add any other local folders you wish to be persistent.
# - --volume <path to local folder>:<path to in-container folder> 
# Note, you do not need to create a docker volume for this method to work. 
