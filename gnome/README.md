# **Customized Gnome**

## **Tweaks and screen settings**

100% scale, font scaling of `1.25`. Subpixel antialiasing and full hinting.
Custom shortcuts in Keyboard settings:

```bash
# Ctrl+Alt+T to run alacritty
env -u WAYLAND_DISPLAY alacritty
# Super+E for file manager
/usr/bin/nautilus
```

TokyoNight-Dark-BL theme: https://www.pling.com/p/1681315 (repo: https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme)

GTK3 theme should be placed at `~/.themes` (after extraction).
GTK4 theme should be placed at `~/.config/gtk4.0`

Themes disappearing after logout: [solved](https://forum.manjaro.org/t/gtk-theme-disappear-after-log-out/123810/12).