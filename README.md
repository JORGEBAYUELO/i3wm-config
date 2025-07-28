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

7. Install and set up feh for wallpapers

8. Set up NetworkManager + nm-applet

9. Configure dual monitors with arandr (for dual monitor setups)

10. Install thunar + file manager plugins

11. Set up polkit-gnome and gnome-keyring

12. Theme everything with lxappearance

---

## Step 1: Installing `i3wm`

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

## Step 2: Install and set up `lightdm + lightdm-webkit2-greeter + webkit2gtk`

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

## Step 3: Install and set up `Picom`

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

## Step 4: Install and set up `Polybar`

### Step 4.1: Install Polybar

**Installing polybar:**

```bash
sudo pacman -S polybar
```

### Step 4.2: Setting up Polybar

**Setting up polybar:**

Create the polybar folder in the .config directory

```bash
mkdir -p ~/.config/polybar/
```

Copy the default configuration file

```bash
cp /etc/polybar/config.ini ~/.config/polybar/config.ini
```

Create a script to launch polybar with i3wm

```bash
touch ~/.config/polybar/launch.sh
```

Open the `launch.sh` file and paste the following configuration

```bash
#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar
echo "---" | tee -a /tmp/polybar1.log
polybar main 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Polybar launched..."
```

Now let's add polybar `launch.sh` script to the `i3` config file

```ini
exec_always --no-startup-id ~/.config/polybar/launch.sh 
```

## Step 5: Install and set up `Rofi`

### Step 5.1: Install Rofi

**Installing rofi:**

```bash
sudo pacman -S rofi
```

### Step 5.2: Set up Rofi

**Create rofi directory:**

```bash
mkdir -p ~/.config/rofi
```

**Create your customization in config.rasi file**

```bash
touch ~/.config/rofi/config.rasi
touch ~/.config/rofi/colors.rasi
```

**Bind rofi in your i3wm config:**

```ini
# start rofi (a more modern launcher)
bindsym $mod+d exec --no-startup-id rofi -show drun
```

## Step 6: Install and set up `Dunst` for notification system

### Step 6.1: Install `Dunst`

**Installing dunst:**

```bash
sudo pacman -S dunst
```

### Step 6.2: Set up `Dunst`

**Setting up dunst:**

Create dunst config directory

```bash
mkdir -p ~/.config/dunst/
```

Copy dunst default config

```bash
cp /etc/dunst/dunstrc ~/.config/dunst/dunstrc
```

Edit the config file to create your personal customization

```bash
vim ~/.config/dunst/dunstrc
```

### Step 6.3: Start Dunst in i3 Config

Add this to your `~/.config/i3/config`:

```bash
# Start dunst notification daemon
exec --no-startup-id dunst
```

## Step 7: Install and set up `Feh` for wallpapers

### Step 7.1: Install `Feh`

**Installing feh**

```bash
sudo pacman -S feh
```

### Step 7.2: Add `Feh` to your i3 config file

**Adding feh to i3**

```ini
exec_always feh --bg-scale ~/.config/wallpapers/wallpaper-theme-converter.png
```

## Step 8: Set up `NetworkManager + nm-applet`

### Step 8.1: Install NetworkManagement

**Installing networkmanagement:**

```bash
# Install NetworkManager and system tray applet
sudo pacman -S networkmanager nm-applet

# Install additional NetworkManager plugins
sudo pacman -S networkmanager-openvpn network-manager-applet
```

### Step 8.2: Install Bluetooth Management

**Installing bluetooth management:**

```bash
# Install Blueman bluetooth manager
sudo pacman -S blueman

# Install bluetooth support packages
sudo pacman -S bluez bluez-utils
```

### Step 8.3: Install Audio Management

**Installing audio management:**

```bash
# Install PulseAudio volume control GUI
sudo pacman -S pavucontrol

# Install PulseAudio system tray
sudo pacman -S pasystray

# Install additional audio tools
sudo pacman -S paprefs  # PulseAudio preferences
```

### Step 8.4: Configure System Tray in i3

**Add these lines to your `~/.config/i3/config`:**

```ini
# Network management
exec --no-startup-id nm-applet

# Bluetooth management  
exec --no-startup-id blueman-applet

# Audio system tray
exec --no-startup-id pasystray

# Volume control keybindings (optional)
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle
bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle

# Open audio controls
bindsym $mod+Shift+a exec pavucontrol
```

Reload your i3 config `$mod+Shift+r`


