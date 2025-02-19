#!/bin/bash
echo "⬇️ Pulling latest changes from Git..."
cd ~/dotfiles && git pull origin main

echo "🔄 Updating symlinks..."
bash ~/dotfiles/install.sh
