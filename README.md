# macOS Dotfiles

This repository contains my personal configuration files (dotfiles) for macOS. It includes settings and configurations for various tools and applications I use daily.

## What's Included

This dotfiles collection includes configurations for:

- **Terminal**: Ghostty terminal emulator with Catppuccin themes
- **Editor**: Neovim with Kickstart configuration
- **Window Management**: Aerospace tiling window manager
- **Custom Status Bar**: Sketchybar with Catppuccin themes integrated with Aerospace
- **System Utilities**: btop system monitor, Borders, TheFuck
- **IDEs**: Zed editor settings
- **And more**: Various other tools and applications

## Installation

Run the installation script:

```zsh
git clone https://github.com/nicholaslck/dotfiles.git ~/dotfiles
~/dotfiles/setup.sh
```

## Tools

This project uses the following tools for management:

- **Just**: A command runner for executing common tasks (see `justfile`)
- **Dotbot**: A tool that bootstraps and configures dotfiles by creating symlinks (see `dotbot.yml`)
- **Brew Bundle**: Homebrew's bundle feature for managing all packages, casks, and taps via `Brewfile`

## Notes

- This repository is designed for ARM macOS systems
- Some applications may need to be restarted or reloaded after installation
- Individual tool configurations may have their own dependencies
- The configurations are tailored to my personal workflow and preferences
- The accent color of Catppuccin is **Rosewater**

Feel free to adapt these configurations to suit your own needs!
