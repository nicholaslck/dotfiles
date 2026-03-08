export XDG_CONFIG_HOME := prepend(env('HOME'), "/.config")
export TPM_DIR := prepend(env('HOME'), "/.config/tmux/plugins/tpm")

link:
    dotbot -c dotbot.yml -v

push:
    git push

install: brew_install link yazi_install tmux_install

[parallel]
update: zap_update brew_update yazi_update tmux_update

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

# Export and save Brewfile
[group('save')]
save_brew:
    scripts/brew-dump.sh .
    git add ./Brewfile

# Move the source config file into dotfiles/ and create a symlink back
[group('save')]
save_config CONFIG_FILE:
    #!/bin/zsh
    # first, replace the absolute path prefix to ~/.config
    # then, move the file into dotfiles/ with the identical folder structure
    # add the link into dotbot.yml
    SOURCE_ABS_PATH={{ absolute_path(CONFIG_FILE) }}
    SOURCE_ABS_PATH_WITH_HOMETAIL="{{ replace(absolute_path(CONFIG_FILE), XDG_CONFIG_HOME, "~/.config") }}"
    DEST_REL_PATH_IN_DOTFILES="{{ replace(absolute_path(CONFIG_FILE), XDG_CONFIG_HOME, "config") }}"

    # check if source file exists
    if test ! -f $SOURCE_ABS_PATH; then
        echo "Source file not found: $SOURCE_ABS_PATH"
        exit 1
    fi
    mv $SOURCE_ABS_PATH $DEST_REL_PATH_IN_DOTFILES
    just link
