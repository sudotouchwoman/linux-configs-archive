# **Use [Fusuma](https://github.com/iberianpig/fusuma) to configure touchpad gestures**

## **Install**:

You might need sendkey plugin if you are running Gnome with `Wayland` (this is the
case for Manjaro on Gnome). `xdotool` will not work in this case.

```bash
# check if you are running Xorg or Wayland
echo $XDG_SESSION_TYPE
# note: xdotool does not work with wayland
sudo pacman -S ruby libinput xdotool
gem i fusuma
gem i revdev bundler fusuma-plugin-sendkey
which fusuma
```

## **Add to path (optional)**

On Arch-based systems, it is recommended to install gems per user (without `sudo`).
Update the `$PATH` so that it includes gems bins. In my case, append 
the following lines to `~/.zshrc` or `~/.bashrc` file (this depends on the shell you are using):

```bash
export PATH=$PATH:~/.local/share/gem/ruby/3.0.0/bin
```

Note that this is quite optional as you may specify a full path to fusuma binary
in `service` file for autostart. You are not likely to run it manually

## **Configure**

Configuration for fusuma is stored at `~/.config/fusuma/config.yml` file, so
you may create it and paste some shortcuts. This directory contains my config as an example.

## **Autostart**

I had to add a custom `systemctl` user service in order to run the gestures daemon on startup.
This can be acieved with the following commands:

Create `fusuma.service` file in `~/.config/systemd/user` (or copy the file from this directory).

```bash
mkdir -p ~/.config/systemd/user
cp fusuma.service ~/.config/systemd/user
```

Now you can check if `systemd` can see your service. Note: **enabling** a service is required
for it to be run on autostart (otherwise it will have status *disabled*; preset: *enabled*)

```bash
systemd --user cat fusuma
systemd --user status fusuma
systemd --user enable fusuma
systemd --user list-unit-files | grep fusuma
```

When the service is running, you might see something like:

```bash
● fusuma.service - Fusuma touchpad gestures
     Loaded: loaded (/home/sudotouchwoman/.config/systemd/user/fusuma.service; enabled; preset: enabled)
     Active: active (running) since Sun 2022-11-06 05:05:43 MSK; 2min 38s ago
   Main PID: 4764 (fusuma)
      Tasks: 7 (limit: 16585)
     Memory: 38.2M
        CPU: 1.199s
     CGroup: /user.slice/user-1000.slice/user@1000.service/app.slice/fusuma.service
             ├─4764 /usr/bin/ruby /home/sudotouchwoman/.local/share/gem/ruby/3.0.0/bin/fusuma
             ├─4771 libinput-debug-events
             ├─4773 grep -v POINTER_ --line-buffered
             └─4775 fusuma/plugin/inputs/timer_input

Nov 06 05:05:43 shitbarn fusuma[4764]: I, [2022-11-06T05:05:43.510766 #4764]  INFO -- :   Fusuma::Plugin::Events::Records::GestureRecord
Nov 06 05:05:43 shitbarn fusuma[4764]: I, [2022-11-06T05:05:43.510772 #4764]  INFO -- :   Fusuma::Plugin::Events::Records::IndexRecord
Nov 06 05:05:43 shitbarn fusuma[4764]: I, [2022-11-06T05:05:43.510778 #4764]  INFO -- :   Fusuma::Plugin::Events::Records::TextRecord
Nov 06 05:05:43 shitbarn fusuma[4764]: I, [2022-11-06T05:05:43.510783 #4764]  INFO -- :   Fusuma::Plugin::Executors::CommandExecutor
```

## **Additional**

As a last resort, I installed [chrome extension](https://chrome.google.com/webstore/detail/mouse-pinch-to-zoom/pffiadlahfhoniddbipeiiohjnlongfi/related?hl=en) for pinch zoom (`ZOOMIN`/`CAMERA_ZOOMIN` keys had no effect in chrome, guess
they suit some other purpose). It enables one to use mouse for pinch zoom while holding `Alt` key.
Not that convenient and natural as pinch, but at least something.

[Useful tutorial](https://dev.to/iberianpig/how-to-install-and-customize-fusuma-73l) by Fusuma creator.
