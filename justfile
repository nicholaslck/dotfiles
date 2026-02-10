export XDG_CONFIG_HOME := prepend(env('HOME'), "/.config")
export TPM_DIR := prepend(env('HOME'), "/.config/tmux/plugins/tpm")

link:
    dotbot -c dotbot.yml -v

push:
    git push

install: brew_install link yazi_install tmux_install

[group('install')]
brew_install:
    brew bundle install --file ./Brewfile

[group('install')]
yazi_install:
    ya pkg install

[group('install')]
tmux_install:
    #!/bin/zsh
    if test ! -d $TPM_DIR; then
      git clone https://github.com/tmux-plugins/tpm $TPM_DIR
    fi
    $TPM_DIR/bin/install_plugins

[group('sync')]
brew_sync:
    scripts/brew-dump.sh .
    git add ./Brewfile

[parallel]
update: zap_update brew_update yazi_update tmux_update

[group('update')]
zap_update:
    #!/bin/zsh
    source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
    zap update all

[group('update')]
brew_update:
    brew update
    brew upgrade --greedy

[group('update')]
yazi_update:
    ya pkg upgrade

[group('update')]
tmux_update:
    #!/bin/zsh
    [ -d $TPM_DIR ] && git -C $TPM_DIR pull
    $TPM_DIR/bin/update_plugins all
