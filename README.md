## What I'm using

- **Window Manager** • [Hyprland](https://github.com/hyprwm/Hyprland) [Bspwm](https://google.com) A tiling Wayland compositor that doesn't sacrifice on its looks 🪟
- **Shell** • [Fish](https://fishshell.com/) With [Fisher](https://github.com/jorgebucaran/fisher), a plugin manager for Fish  🐚
- **Terminal** • [Foot](https://codeberg.org/dnkl/foot) or [Kitty](https://sw.kovidgoyal.net/kitty/) A fast, lightweight and customizable terminal 💻
- **Panel** • [Waybar](https://aur.archlinux.org/packages/waybar-hyprland-git) Highly customizable Wayland bar, now with workspaces support for Hyprland 📊
- **Notify Daemon** • [Mako](https://github.com/emersion/mako) A lightweight notification daemon 📣
- **Launcher** • [Wofi](https://github.com/uncomfyhalomacro/wofi) A window switcher, application launcher and dmenu replacement 🔍
- **File Manager** • [Thunar](https://github.com/xfce-mirror/thunar) A modern file manager designed from the ground up to be fast and easy to use 📁
- **Wallpaper** • [Swaybg](https://github.com/swaywm/swaybg) A solution to Wayland wallpaper woes 🌄

--- 

## Previev (Hyprland) 🚀

### Workspace

![workspaces](https://github.com/Cstrp/dotfiles/blob/main/assets/Screenshot1.png)

### Spotify + Cava

![spotify](https://github.com/Cstrp/dotfiles/blob/main/assets/Screenshot2.png)

## Tree of files 🌱

```bash
~
├── .mozila
│   ├── 📁  firefox
│   │   ├── 📁 chrome
│   📓 user.js
├── .config
│   ├── 📁  bspwm
│   ├── 📁  cava
│   ├── 📁  fish
│   ├── 📁  nwg-look
│   ├── 📁  powershell
│   ├── 📁  swaylock  
│   ├── 📁  foot             
│   ├── 📁  gtk-3.0
│   ├── 📁  gtk-4.0 
│   ├── 📁  kitty 
│   ├── 📁  pipewire
│   ├── 📁  spicetify 
│   ├── 📁  wlogout
│   ├── 📁  hypr
│   │   ├── 📁  mako
│   │   ├── 📁  wofi
│   │   ├── 📁  scripts
│   │   ├── 📁  themes
│   │   ├── 📓 monitors.conf
│   │   ├── 📓 env.conf 
│   │   ├── 📓 exec.conf
│   │   ├── 📓 keybinds.conf
│   │   └── 📓 hyprland.conf
│   ├── 📁  nwg-look
│   ├── 📁  Thunar
│   └── 📁  wlogout
📓 .gitconfig   
📓 settings.json
📓 .Xresources
📓 starship.toml
```

## Keybinds ⇩

| Shortcut                | Description                                                  |
| ----------------------- | ------------------------------------------------------------ |
| `$mainMod` + `SHIFT` + `C` | Reload hyprctl                                            |
| `$mainMod` + `SHIFT` + `D` | Open fullmenu                                             |
| `$mainMod` + `E`         | Execute menu script                                         |
| `$mainMod` + `SHIFT` + `Q` | Kill active window                                        |
| `$mainMod` + `T`         | Toggle floating for active window                           |
| `$mainMod` + `F`         | Toggle fullscreen for active window                         |
| `$mainMod` + `Q`         | Kill active window                                          |
| `$mainMod` + `Return`    | Open terminal                                               |
| `$mainMod` + `SHIFT` + `T` | Open file manager (Thunar)                                |
| `$mainMod` + `SHIFT` + `B` | Open Firefox Nightly browser                              |
| `$mainMod` + `SHIFT` + `G` | Execute gamemode.sh script                                |
| `$mainMod` + `L`         | Lock the screen                                             |
| `$mainMod` + `CTRL` + `S` | Execute wofi-beats script                                  |
| `$mainMod` + `W`         | Change wallpaper                                            |
| `$mainMod` + `SHIFT` + `W` | Change Waybar style                                       |
| `$mainMod` + `CTRL` + `W` | Execute wallpaper-switcher script                          |
| `$mainMod` + `B`         | Kill Waybar (SIGUSR1 signal)                                |
| `$mainMod` + `Print`     | Take a screenshot                                           |
| `$mainMod` + `CTRL` + `SHIFT` + `Print` | Take a delayed screenshot                    |
| `$mainMod` + `SHIFT` + `Print` | Take a screenshot of a selected area                  |
