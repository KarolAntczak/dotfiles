# dotfiles

My configs for Arch + Hyprland. Based heavily on [Catppuccin](https://catppuccin.com/palette/) color palette.



## Screenshot

![Desktop](assets/screenshots/screenshot.png)


## Usage

The simplest way is to use [GNU stow](https://www.gnu.org/software/stow/): 

```bash
stow hypr waybar rofi kitty # ... and other configs you need
```
For SDDM, you have to copy contents manually (symlinks don't work, unfortunately).  

You can also copy contents of each config manually, without using stow at all. 

All dependencies are in pkglist.txt. You can install them with yay: `yay -S --needed < pkglist.txt`. Note, however, that they list ALL my essential packages. 
