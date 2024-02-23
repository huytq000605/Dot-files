# Linux Setting
Switch to next input source: Alt + Z

Install Dash to Panel

Minimize on click

Launch Terminal: Alt + T

Copy a screenshot of an area to clipboard : Super + Shift + S

Move to Work Space Above / Below : Disabled

Universal Access => Typing => Repeat Keys
- WSL: `apt-get install x11-xserver-utils` -> `xset r rate 240 40`
  - 240 - is a milliseconds delay before repeating starts
  - 40 - the rate of repetition after the delay

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
- Scroll Reverser (Touchpad)
# Shell

- Install ZSH

- Install Oh my ZSH
- ZSH Syntax Highlighting https://github.com/zsh-users/zsh-syntax-highlighting
- ZSH Auto suggestions https://github.com/zsh-users/zsh-autosuggestions
- Install Powerlevel 10k Theme (Remember to install font)

- Install Fzf

- Install Ripgrep


# Editor
Setup Nvim

Download nvim.appimage

Put somewhere ( ex: ~/ ), create symbolink in /usr/bin/nvim by:
```
ln -s ~/nvim.appimage /usr/bin/nvim
```

Create config folder in ~/.config/nvim by: 
```
mkdir -p ~/.config/nvim
```

Copy this **init.lua** to above folder

Install Language Server

# Terminal
Setup Kitty

Add config file (kitty.conf) to ~/.config/kitty/

Install kitty scrollback: https://github.com/mikesmithgh/kitty-scrollback.nvim
