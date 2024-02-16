# Bluetooth Speaker with Pipewire
Turn your bluetooth device into a receiver. Example: Connect your mobile (source, no audio jack) to your HiFi (audio jack, no bluetooth) using a raspberryPi inbetween, as it has both: bluetooth and an audio jack. 

This project uses https://github.com/fdanis-oss/pw_wp_bluetooth_rpi_speaker and turns it into a docker image.

## How does it work
When the container is run it binds `/var/run/dbus/system_bus_socket` and thus allows the container to act upon it. The script speaker-agent.py is run (with optional --single-connection parameter) and starts to do its service in isolation. When you do not need this service any longer just stop the container.

## Dependencies
This container requires the host to run pipewire and wireplumber.

## Persistently running
Pipewire and wireplumber run in userspace and are stopped when you logout. So the user needs to stay logged in and it is not suficient to keep a process open (screen, tmux, byobu, ...). If you want to run this service headless persistently you could enable auto login:

```
sudo systemctl edit getty@tty1.service
```

and insert (by replacing the $USERNAME) with your own:

```
[Service]
ExecStart=
ExecStart=-/sbin/agetty --noissue --autologin $USERNAME %I $TERM
Type=idle
```
