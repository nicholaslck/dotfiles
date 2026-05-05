# Homebrew environment on ARM macOS (via brew shellenv --zsh)
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
eval "$(/usr/bin/env PATH_HELPER_ROOT="/opt/homebrew" /usr/libexec/path_helper -s)"
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

# flutter
export PATH="$HOME/development/flutter/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$HOME/.lmstudio/bin:$PATH"

# ruby (via homebrew)
export PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/lib/ruby/gems/4.0.0/bin:$PATH"

# python (via homebrew)
export PATH="$HOMEBREW_PREFIX/opt/python@3.14/libexec/bin:$PATH"

# Ruby Gems (mostly for Cocoapods)
export GEM_HOME=$HOME/.gem
export PATH=$HOME/.gem/bin:$PATH

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
export PATH="$HOME/.bun/bin:$PATH"

# CHROME_EXECUTABLE for flutter
export CHROME_EXECUTABLE="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Android SDK
export ANDROID_HOME=$HOME/Library/Android/sdk

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Added by Obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/nicholaslck/.lmstudio/bin"
# End of LM Studio CLI section
