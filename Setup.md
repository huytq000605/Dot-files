# Linux Setting
Switch to next input source: Alt + Z

Install Dash to Panel

Minimize on click

Launch Terminal: Alt + T

Copy a screenshot of an area to clipboard : Super + Shift + S

Move to Work Space Above / Below : Disabled

Universal Access => Typing => Repeat Keys

Vietnamese: Ibamboo

Turnoff Mouse acceleration

Dim brightness

Gnome-tweaks


![](assets/extensions.png)

# MacOS

- Karabiner
- Copy setup Karabiner
``` bash
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 12
```
![](assets/mac_os_keyboard.png)
![](assets/shortcut.png)

# Shell

- Install ZSH

- Install Oh my ZSH
- ZSH Syntax Highlighting https://github.com/zsh-users/zsh-syntax-highlighting
- ZSH Auto suggestions https://github.com/zsh-users/zsh-autosuggestions
- Install Powerlevel 10k Theme (Remember to install font)

- Install Fzf

- Install Ripgrep

- Install Kitty (Terminal):

Add config file (kitty.conf) to ~/.config/kitty/


# Editor
Setup Nvim

Download nvim.appimage

Put somewhere ( ex: ~/ ), create symbolink in /usr/bin/nvim by:
```
ln -s ~/nvim.appimage /usr/bin/nvim
```

Install Vim Plug:

Create config folder in ~/.config/nvim by: 
```
mkdir -p ~/.config/nvim
```

Copy this **init.vim** to above folder

Run :PlugInstall the first time

Install Language Server
