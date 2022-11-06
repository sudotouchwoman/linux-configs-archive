# **Some configs for useful services with notes**

Bunch of configuration files, installation advices and notes for different
useful utilities gathered from all over the forums. These notes apply to 
Manjaro linux running Gnome under Wayland, but this may only make difference
for WM-related stuff.

### **Essential commands:**

```bash
# install package (Sync)
sudo pacman -S <package-name>
sudo pacman -S --needed git base-devel
# search for the package in repos
sudo pacman -Ss <package-name>
# update
sudo pacman -Syu
# remove package and its deps
sudo pacman -Rsn <package-name>
# system configuration
inxi -F
# check memory
cat /proc/meminfo
free
htop
# check uptime, status, etc
neofetch
```

**Basic tools from AUR:**

```bash
# this can probably be done easier with yay/paru
git clone https://aur.archlinux.org/visual-studio-code-bin.git
cd visual-studio-code-bin && makepkg -si && cd ..
pacman -S alacritty
git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si && cd ..
# CLI theming tool
paru -S alacritty-themes
git clone https://aur.archlinux.org/yay-git.git && cd yay-git && makepkg -si && cd ..
yay -S google-chrome
```

### **TLP:**

I use tlp to switch between battery conservation modes. My laptop supports
so-called conservation mode, which prevents battery from charging above 60%.

```bash
# check battery status
tlp-stat -b
# entire tlp configuration
tlp-stat
# must be run once
systemctl enable tlp.service
systemctl is-enabled tlp
# set conservation mode
tlp setecharge
# charge to 100%
tlp fullcharge
```
