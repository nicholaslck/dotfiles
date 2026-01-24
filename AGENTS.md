# AGENTS.md

## Repository Overview

This is a personal macOS dotfiles repository containing configuration files for various tools, terminal applications, and development environments. The repository is designed for ARM macOS systems and follows a minimalist approach to configuration management.

## Key Commands

### Installation & Setup
```bash
# Full installation
~/.config/install.sh

# Homebrew dependency management
brew bundle install --file ~/.config/homebrew/Brewfile
~/.config/homebrew/bundle_dump.sh

# Shell configuration reload
exec zsh
```

### Development Tools
```bash
# Neovim (primary editor)
nvim

# Git operations
lazygit

# File management
yazi

# Terminal multiplexing and utilities
zoxide init --cmd "cd" zsh
fzf
```

### Testing & Validation
```bash
# Gitleaks scanning (for security)
gitleaks git            # Scan entire git history for secrets
gitleaks git --staged    # Scan staged changes for secrets (pre-commit)
gitleaks dir             # Scan directories and files for secrets

# Configuration validation
# (Tool-specific commands vary)
```

## Code Style Guidelines

### General Principles
- **Minimalism**: Keep configurations simple and focused
- **Single source of truth**: Each tool has one authoritative configuration file
- **Version control**: Track all configuration files except sensitive data and caches
- **Documentation**: Comment complex configurations but keep simple ones self-explanatory

### File Organization
- Follow XDG Base Directory specification where applicable
- Tool configs in `~/.config/<tool>/` structure
- Shell scripts in `~/.config/zsh/` with subdirectories:
  - `comps/` - custom completions
  - `scripts/` - utility scripts
- Use descriptive filenames with no spaces or special characters

### Shell Scripting (Zsh)
```bash
# Use modern Zsh syntax
# Prefer builtins over external commands
# Quote variables: "$VAR" not $VAR
# Use [[ ]] for conditional tests
# Functions over aliases for complex operations

# Good example
custom_func() {
    local file="$1"
    [[ -f "$file" ]] || return 1
    echo "Processing: $file"
}

# Aliases for simple shortcuts
alias ll="ls -lah"
alias vim="nvim"
```

### Neovim Configuration (Lua)
```lua
-- Use functional programming style
-- Local variables at top of scope
-- Prefer vim.keymap.set over vim.api.nvim_set_keymap
-- Use lazy.nvim for plugin management
-- Modular configuration in lua/kickstart/plugins/

local opt = vim.opt
local g = vim.g

opt.number = true
opt.relativenumber = true
```

### JSON Configuration
- Use 2-space indentation
- Sort keys alphabetically for consistency
- Remove trailing commas
- Use double quotes exclusively

### Python Configuration
- Follow PEP 8 style
- Use type hints where beneficial
- Prefer pathlib over os.path
- Keep scripts under 100 lines when possible

### Git Workflow
```bash
# Commit messages: imperative mood, 50 chars max
git commit -m "Add zsh completion for pnpm"

# Branch naming: feature/description or bugfix/description
git checkout -b feature/add-tool-config

# Pre-commit checks
gitleaks git --staged
```

## Tool-Specific Guidelines

### Homebrew
- Track all formulas and casks in Brewfile
- Use `~/.config/homebrew/bundle_dump.sh` to update after changes (excludes dependencies)
- Prefer casks for GUI applications, formulas for CLI tools

### Zsh Configuration
- Use Zap plugin manager
- Load plugins in order: core functionality -> completions -> UI
- Custom completions in `comps/` directory
- Environment variables in `.zshrc`

### Neovim
- Based on kickstart.nvim
- Lazy.nvim for plugin management
- Keymaps use `<leader>` prefix for custom bindings
- LSP configured per language as needed

### Yazi File Manager
- Shell integration via `shell.sh`
- Plugins in dedicated plugins directory
- Theme configuration separate from functional config

## Security Considerations

- Never commit secrets or API keys
- Use gitleaks for secret scanning
- Review `.gitignore` excludes sensitive data:
  - `.DS_Store`
  - `__pycache__/`
  - Application-specific cache directories
- Use environment variables for configuration that needs to be portable

## Common Patterns

### Adding New Tools
1. Add to Brewfile if available via Homebrew
2. Create config directory in `~/.config/<tool>/`
3. Add shell completion if available
4. Create aliases in `.zshrc` if needed
5. Update this documentation

### Configuration Updates
1. Test changes in isolated environment
2. Update relevant configuration files
3. Run `gitleaks git` to check for secrets
4. Commit with descriptive message
5. Test installation script if changes affect setup

### Cross-Platform Considerations
- This repository is macOS-specific (ARM)
- Use `$(uname)` checks if adding cross-platform support
- Prefer portable file paths and commands
- Document platform-specific requirements

## File Exclusions

The `.gitignore` excludes:
- macOS metadata files (`.DS_Store`)
- Python cache directories (`__pycache__/`)
- Third-party application data (flutter/, raycast/, etc.)
- Temporary files and build artifacts

## Maintenance

Regular maintenance tasks:
- Update Brewfile after package changes using `bundle_dump.sh`
- Review and update plugin versions
- Clean up unused configurations
- Verify installation script works on fresh systems
- Update documentation for new tools or patterns