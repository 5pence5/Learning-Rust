#!/bin/bash

set -e  # Exit on error

echo "Starting Neovim installation..."

# Create a local installation directory
mkdir -p ~/.local/nvim

# Backup existing Neovim installation if it exists
if [ -d ~/.local/nvim ]; then
    echo "Backing up existing Neovim installation..."
    mv ~/.local/nvim ~/.local/nvim.backup.$(date +%Y%m%d_%H%M%S)
fi

# Create fresh directory
mkdir -p ~/.local/nvim

# Install Neovim
echo "Downloading Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

echo "Extracting Neovim..."
tar -xzf nvim-linux64.tar.gz
cp -r nvim-linux64/* ~/.local/nvim/
rm -rf nvim-linux64.tar.gz nvim-linux64

# Create necessary directories
mkdir -p ~/.local/nvim/bin
mkdir -p ~/.config

# Install dependencies
sudo apt-get update && sudo apt-get install -y \
    git \
    curl \
    build-essential \
    nodejs \
    npm

# Add Neovim to PATH (create a new file to avoid duplicate entries)
echo 'export PATH="$HOME/.local/nvim/bin:$PATH"' > ~/.local/env
echo 'source ~/.local/env' >> ~/.bashrc

# Set up VS Code keybindings
mkdir -p ~/.vscode-remote/data/User
cat > ~/.vscode-remote/data/User/keybindings.json << 'EOF'
[
  // Neovim - Normal Mode
  {
    "key": "ctrl+y",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'normal'",
    "args": "<C-y>"
  },
  {
    "key": "ctrl+e",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'normal'",
    "args": "<C-e>"
  },
  // NeoVim - Insert Mode
  {
    "key": "ctrl+y",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-y>"
  },
  {
    "key": "ctrl+l",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-l>"
  },
  {
    "key": "ctrl+e",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-e>"
  },
  {
    "key": "ctrl+x",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-x>"
  },
  {
    "key": "ctrl+p",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-p>"
  },
  {
    "key": "ctrl+n",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-n>"
  },
  {
    "key": "ctrl+z",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-z>"
  },
  {
    "key": "ctrl+h",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-h>"
  },
  {
    "key": "ctrl+m",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-m>"
  },
  {
    "key": "ctrl+i",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-i>"
  },
  {
    "key": "ctrl+k",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-k>"
  },
  {
    "key": "ctrl+b",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-b>"
  },
  {
    "key": "ctrl+g",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-g>"
  },
  {
    "key": "ctrl+q",
    "command": "vscode-neovim.send",
    "when": "editorTextFocus && neovim.init && neovim.mode == 'insert'",
    "args": "<C-q>"
  }
]
EOF

# Set up VS Code settings
mkdir -p ~/.vscode-remote/data/Machine
cat > ~/.vscode-remote/data/Machine/settings.json << EOF
{
    "vscode-neovim.neovimExecutablePath": "$HOME/.local/nvim/bin/nvim",
    "editor.lineNumbers": "relative",
    "vscode-neovim.neovimInitVimPaths": "~/.config/nvim/init.lua",
    "keyboard.dispatch": "keyCode",
    "editor.cursorStyle": "block",
    "workbench.colorTheme": "Default Dark+"
}
EOF

# Clone the VSCode-NeoVim configuration
rm -rf ~/.config/nvim
git clone https://github.com/AGutierrezR/VSCode-NeoVim.git ~/.config/nvim

# Make Neovim executable
chmod +x ~/.local/nvim/bin/nvim

# Update current session's PATH
export PATH="$HOME/.local/nvim/bin:$PATH"

# Source bashrc and print success message
source ~/.bashrc
echo "Installation complete! Neovim has been installed and configured."

# Verify the installation
if command -v nvim &> /dev/null; then
    echo "Neovim is successfully installed at: $(which nvim)"
    nvim --version
else
    echo "Warning: Neovim installation may have failed. Please check the installation."
fi