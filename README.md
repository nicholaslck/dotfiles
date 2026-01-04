# macOS Dotfiles

This repository contains my personal configuration files (dotfiles) for macOS. It includes settings and configurations for various tools and applications I use daily.

## What's Included

This dotfiles collection includes configurations for:

- **Terminal**: Ghostty terminal emulator with Catppuccin themes
- **Editor**: Neovim with Kickstart configuration
- **Window Management**: Aerospace tiling window manager
- **System Utilities**: btop system monitor, Borders, TheFuck
- **IDEs**: Zed editor settings
- **And more**: Various other tools and applications

## Installation

There are two simple ways to install these dotfiles:

### Method 1: Clone and Symlink

1. Clone this repository to your desired location:

   ```bash
   git clone https://github.com/nicholaslck/dotfiles.git ~/dotfiles
   ```

2. Create symbolic links to the `~/.config` folder:
   ```bash
   cd ~/dotfiles
   for file in *; do
     if [ -d "$file" ]; then
       ln -s "$(pwd)/$file" "$HOME/.config/$file"
     fi
   done
   ```

### Method 2: Direct Clone

Clone the repository directly into your `~/.config` folder:

```bash
git clone https://github.com/nicholaslck/dotfiles.git ~/.config
```

## Notes

- This repository is designed for macOS systems
- Some applications may need to be restarted or reloaded after installation
- Individual tool configurations may have their own dependencies
- The configurations are tailored to my personal workflow and preferences

Feel free to adapt these configurations to suit your own needs!
