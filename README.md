# My i3wm Configuration

This is a full guide, to build an i3wm configuration from scratch that can be replicated in other setups.

## What We Need to Install

Check list of tools that we will install:

### Configuration Workflow

1. Install i3wm + i3blocks

2. Install and set up lightdm + lightdm-webkit2-greeter + webkit2gtk

3. Install and setup up picom for compositing

4. Install and set up polybar

5. Install and set up Rofi as launcher

6. Install and set up dunst for notification system

7. Use feh or nitrigen for wallpapers

8. Set up NetworkManager + nm-applet

9. Configure dual monitors with arandr (for dual monitor setups)

10. Install thunar + file manager plugins

11. Set up polkit-gnome and gnome-keyring

12. Theme everything with lxappearance

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

## Step 2: Install and set up lightdm + lightdm-webkit2-greeter + webkit2gtk

### Step 2.1: Installing lightdm + lightdm-webkit2-greeter + webkit2gtk

**Install lightdm:**

```bash
sudo pacman -S lightdm
```

**Install lightdm-webkit2-greeter:**

```bash
yay -S lightdm-webkit2-greeter
```

**Install webkit2gtk dependency:**

```bash
sudo pacman -S webkit2gtk
```

### Step 2.2: Configure lightdm.conf
**Configure lightdm.conf file:**

```bash
sudo vim /etc/lightdm/lightdm.conf
```

**Find and modify these lines:**

```ini
[Seat:*]
#greeter-session=example-gtk-gnome
greeter-session=lightdm-webkit2-greeter
#user-session=default
user-session=i3
```

**Enable lightdm:**

```bash
sudo systemctl enable lightdm
```

**Start lightdm:**

```bash
sudo systemctl start lightdm
```

## Step 3: Install and set up Picom

### Step 3.1: Install Picom

**Install Picom:**

```bash
sudo pacman -S picom
```

### Step 3.2: Set up Picom

**Setting up picom:**

Create the picom folder in the .config directory

```bash
mkdir -p ~/.config/picom/
```

Copy the default configuration file

```bash
cp /etc/xdg/picom.conf ~/.config/picom/picom.conf
```

### Step 3.3: Add picom to the i3wm

To have Picom automatically launch when you start your window manager, add the following line to the i3 configuration file.

**Edit the i3 config file:**

```bash
vim .config/i3/config
```

**Add the following line to the configuration**

```ini
exec_always --no-startup-id picom -b
```

Now reload the i3 configuration by pressing `$mod+Shift+r`.


