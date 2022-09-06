#!/bin/bash

LOG="/dev/null"

_progress() {
  echo "$(date) PROCESSING:  $*" >> "$LOG"
  printf "$(tput setaf 6) %s...$(tput sgr0)\n" "$@"
}

if [[ $1 = "--test" || $1 = "-t" ]]; then
    _progress "Building test env"
    docker build . -t dotfile-install-test
    _progress "Entering test container"
    docker run -it dotfile-install-test /bin/bash
    _progress "Closing test env"
    exit 0
elif [[ -z $1 ]]; then
    LOG="/dev/null"
fi

_get_package_manager() {
    _progress "Selecting package manager"
    printf "\nWhich $(tput bold)package manager$(tput sgr0) do you want to use?\n"
    printf "  1. $(tput setaf 2)homebrwew\n$(tput sgr0)"
    printf "  2. $(tput setaf 3)apt$(tput sgr0)\n"
    read -r package_option

    # Invalid option handling
    if [[ 1 -ne package_option && 2 -ne package_option ]]; then
        _progress "Invalid package manager option. Exiting"
        exit 1
    fi

    if [[ 1 = "$package_option" ]]; then
        _progress "Checking for Homebrew installation"
        if ! brew --version >/dev/null 2>/dev/null; then
            _progress "Installing Homebrew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
            _progress "Sourcing brew"
            if [[ $LOCAL_OS = "macos" ]]; then
                echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> /Users/"$(whoami)"/.zprofile
                eval "$(/opt/homebrew/bin/brew shellenv)"
            else
                echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/linuxbrew/.profile
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
            fi
            _progress "Running brew doctor"
            if ! brew doctor; then
                _progress "Brew installation failed. Exiting"
                exit 1
            fi
        else
            _progress "Homebrew already installed"
        fi
        INSTALL="brew install"
        _progress "Using brew"
    else
        INSTALL="sudo apt-get install -y"
        _progress "Using apt-get"
    fi
}

install_deps=(git fd ripgrep clang shellcheck cmake tmux)
_install_basics() {
    for dep in "${install_deps[@]}"; do
        _progress "Installing $dep"
        eval "$INSTALL $dep"
    done

    if [ "$LOCAL_OS" = "macos" ]; then
        _progress "Getting xcode cli tools"
        xcode-select --install
        _progress "Finished getting xcode cli tools"
    fi
}

_get_os_cpu() {
    if [ "$(uname)" == "Darwin" ]; then
        LOCAL_OS="macos"
    elif [ "$(uname)" == "Linux" ]; then
        LOCAL_OS="linux"
    fi
    ARCH="$(uname -m)"
    _progress "Running $LOCAL_OS on $ARCH"
}

cargo_deps=(cargo-watch cargo-edit cargo-clippy stylua shellharden)
install_rust() {
    _progress "Installing rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    _progress "Finished installing rust"
    if [ "$LOCAL_OS" = "linux" ]; then
        source "$HOME/.cargo/env"
    fi

    _progress "Installing rust dependencies"
    for dep in "${cargo_deps[@]}"; do
        cargo install "$dep"
    done
    _progress "Finished installing rust dependencies"
}

node_deps=(yarn)
install_node() {
    _progress "Getting node.js"
    curl https://www.npmjs.org/install.sh | sh
    _progress "Finished getting node.js"

    _progress "Getting nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    _progress "Finished getting nvm"


    _progress "Installing npm dependencies"
    for dep in "${node_deps[@]}"; do
        npm install "$dep" --global
    done
    _progress "Finished installing npm dependencies"
}

install_oh_my_zsh() {
    # zsh is included on macos
    if [ "$LOCAL_OS" = "linux" ]; then
        _progress "Installing zsh"
        eval "$INSTALL zsh"
        _progress "Finished installing zsh"
    fi

    _progress "Setting zsh as default shell"
    chsh -s "$(which zsh)"

    _progress "Checking oh-my-zsh installation"
    if [ -d ~/.oh-my-zsh/ ]; then
        read -rp "It looks like oh-my-zsh is already installed. Would you like to install anyway? (y/n)" force_zsh_install
    else
        force_zsh_install="y"
    fi

    if [ "$force_zsh_install" = "y" ] || [ "$force_zsh_install" = "Y" ]; then
        _progress "Installing oh-my-zsh"
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        _progress "Finished installing oh-my-zsh"
    fi

    _progress "Getting p10k for zsh"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
    _progress "Finished getting p10k"
}

python_deps=(guizero pygame thefuck virtualenv black flake8)
install_python() {
    _progress "Installing python3"
    if [ "$LOCAL_OS" = "linux" ]; then
        sudo apt-get install software-properties-common
        sudo add-apt-repository ppa:deadsnakes/ppa
        sudo apt-get update
        sudo apt-get install python3.11
        sudo apt-get install python3-pip
    else
        eval "$INSTALL" python3
    fi
    _progress "Finished installing python3"

    _progress "Installing python dependencies"
    for dep in "${python_deps[@]}"; do
        pip install "$dep"
    done
    _progress "Finished installing python dependencies"
}

install_neovim() {
    if [ "$LOCAL_OS" = "macos" ]; then
        brew install neovim --head
        return
    fi
    
    prevdir=$PWD

    # Build from source on linux since the releases on github for linux64 don't include the dev version of neovim
    _progress "Getting neovim source and dependencies"
    git clone https://github.com/neovim/neovim.git ~/.neovim
    sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y

    _progress "Building neovim"
    cd ~/.neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo

    _progress "Installing neovim"
    if ! sudo make install; then
        _progress "Neovim installation failed. Exiting"
    fi

    _progress "Neovim installation complete"
    cd "$prevdir" && return
}

get_dotfiles() {
    _progress "Downloading dotfiles"
    git clone https://github.com/BeaconBrigade/dotfiles.git ~/.dotfiles/
    cd ~/.dotfiles
    _progress "Copying neovim dotfiles"
    mkdir -p ~/.config/nvim
    make nvim
    _progress "Copying zsh dotfiles"
    make zsh
    _progress "Copying tmux dotfiles"
    make tmux
    cd ~
    _progress "Done getting dotfiles"
}

install() {
    _progress "Starting script"
    _get_os_cpu
    _get_package_manager
    _install_basics
    install_node
    install_oh_my_zsh
    install_rust
    install_python
    install_neovim
    get_dotfiles
    _progress "Done installing everything!!"
}

install
