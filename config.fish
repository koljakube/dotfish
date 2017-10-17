# Install fonts for all users.
set -gx HOMEBREW_CASK_OPTS --fontdir=/Library/Fonts

# iTerm2's shell integration (installed via iTerm2 itself).
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
