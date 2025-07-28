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

9. Install thunar + file manager plugins

10. Set up polkit-gnome and gnome-keyring

11. Theme everything with lxappearance

12. Configure dual monitors with arandr (for dual monitor setups)

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

## Step 9: Install `thunar` + file manager plugins

### Step 9.1: Install `thunar` and core components

**Installing thunar:**

```bash
# Install Thunar file manager
sudo pacman -S thunar

# Install essential Thunar plugins
sudo pacman -S thunar-volman thunar-archive-plugin thunar-media-tags-plugin

# Install additional useful plugins
sudo pacman -S gvfs gvfs-mtp gvfs-gphoto2 gvfs-smb gvfs-nfs
```

**Installing archive support:**

```bash
# For handling zip, rar, 7z files through Thunar
sudo pacman -S file-roller unzip unrar p7zip
```

**Installing thumbnail support**

```bash
# For image and video thumbnails
sudo pacman -S tumbler ffmpegthumbnailer

# For PDF thumbnails
sudo pacman -S poppler-glib
```

### Step 9.2: Set Thunar as default file manager

**Setting up thunar:**

Install xdg-utils:

```bash
sudo pacman -S xdg-utils
```

Then run the command:

```bash
# Set Thunar as default file manager
xdg-mime default thunar.desktop inode/directory application/x-gnome-saved-search
```

### Step 9.3: Add Thunar Keybinding to i3

**Add this to your `~/.config/i3/config`:**

```bash
# File manager keybinding
bindsym $mod+s exec thunar
```

### Step 9.4: Configure Thunar

**Launch Thunar and configure:**

1. **Open Thunar:** thunar or press your new keybinding

2. **Go to Edit → Preferences**

3. **In the "Advanced" tab:**

    - Enable "Enable Volume Management"

    - Check "Mount removable drives when hot-plugged"

    - Check "Mount removable media when inserted"

## Step 10: Set up `polkit-gnome` and `gnome-keyring`

### Step 10.1: Install required packages

**Installing required packages:**

```bash
# Install polkit-gnome for authentication dialogs
sudo pacman -S polkit-gnome

# Install gnome-keyring for password management
sudo pacman -S gnome-keyring

# Install seahorse (GUI for managing keys and passwords)
sudo pacman -S seahorse

# Install libsecret for application password storage
sudo pacman -S libsecret
```

### Step 10.2: Configure polkit-gnome in i3

**Add this to your `~/.config/i3/config`:**

```ini
# Authentication agent
exec --no-startup-id /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 
```

```ini
# GNOME Keyring
exec --no-startup-id gnome-keyring-daemon --start --components=pkcs11,secrets,ssh
```

### Step 10.3: Set Up PAM Configuration

**Edit the PAM configuration to unlock keyring on login:**

```bash
# Edit the login PAM file
sudo vim /etc/pam.d/login
```

Add this line at the end:

```ini
auth       optional     pam_gnome_keyring.so
session    optional     pam_gnome_keyring.so auto_start
```

**Edit the passwd PAM file:**

```bash
sudo vim /etc/pam.d/passwd
```

Add this line at the end:

```ini
password   optional     pam_gnome_keyring.so 
```

### Step 10.4: Configure LightDM for Keyring Integration

**Edit your LightDM configuration:**

```bash
sudo vim /etc/lightdm/lightdm.conf
```

Find the `[Seat:*]` section and add:

```ini
[Seat:*]
session-setup-script=/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets
```

### Step 10.5: Set Environment Variables

**Add these to your `~/.profile`:**

```bash
vim ~/.profile
```

Add these lines:

```ini
# GNOME Keyring
export GNOME_KEYRING_CONTROL=/run/user/$UID/keyring
export SSH_AUTH_SOCK=$GNOME_KEYRING_CONTROL/ssh
```

### Step 10.6: Create Keyring Startup Script

**Keyring startup script:**

```bash
vim ~/.config/i3/scripts/keyring-start.sh 
```

Add this content:

```bash
#!/bin/bash

# Kill any existing keyring daemons
killall gnome-keyring-daemon 2>/dev/null

# Start gnome-keyring-daemon
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID
```

Make it executable:

```bash
chmod +x ~/.config/i3/scripts/keyring-start.sh 
```

Update your i3 config to use the script:

```bash
# Replace the previous keyring line with:
exec --no-startup-id ~/.config/i3/scripts/keyring-start.sh 
```

Restart i3:

```bash
$mod+Shift+r 
```


