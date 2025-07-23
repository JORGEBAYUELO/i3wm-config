# My i3wm Configuration

This is a full guide, to build an i3wm configuration from scratch that can be replicated in other setups.

## What We Need to Install

Check list of tools that we will install:

### Configuration Workflow

1. Install i3wm + i3blocks

2. lightdm + lightdm-gtk-greeter

2. Install and set up polybar

3. Install and setup up picom for compositing

4. Install and set up Rofi as launcher

5. Install and set up dunst for notification system

6. Use feh or nitrigen for wallpapers

7. Set up NetworkManager + nm-applet

8. Configure dual monitors with arandr (for dual monitor setups)

9. Install thunar + file manager plugins

10. Set up polkit-gnome and gnome-keyring

11. Theme everything with lxappearance

## Step 1: Installing i3

In my case, I'm using **Arch Linux**

```bash
sudo pacman -S i3
```

Make sure to install a terminal, `Kitty` or `Alacritty` will work just fine. You can always change the terminal in the i3 config file.

```bash
sudo pacman -S alacritty
```

Install dmenu (we will later change this for Rofi)

```bash
sudo pacman -S dmenu
```

## Step 2: Install lightdm + lightdm-gtk-greeter

Installing lightdm + lightdm-gtk-greeter

```bash
sudo pacman -S lightdm lightdm-gtk-greeter 
```

Enable lightdm

```bash
sudo systemctl enable lightdm
```

configure lightdm

```bash
sudo vim /etc/lightdm/lightdm.conf
```

Find and modify these lines:

```ini
[Seat:*]
#greeter-session=example-gtk-gnome
greeter-session=lightdm-gtk-greeter
#user-session=default
user-session=i3
```

Start lightdm

```bash
sudo systemctl start lightdm
```
