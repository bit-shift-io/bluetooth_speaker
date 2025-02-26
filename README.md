# Bluetooth Speaker with Pipewire

Forked from: https://github.com/codingdave/bluetooth_speaker and modified to allow any bluetooth device to connect.

Turn your bluetooth device into a receiver. Example: Connect your mobile (source, no audio jack) to your HiFi (audio jack, no bluetooth) using a raspberryPi inbetween, as it has both: bluetooth and an audio jack. 

This project uses https://github.com/fdanis-oss/pw_wp_bluetooth_rpi_speaker and turns it into a docker image.

## How does it work
When the container is run it binds `/var/run/dbus/system_bus_socket` and thus allows the container to act upon it. The script speaker-agent.py is run (with optional `--single-connection` parameter) and starts to do its service in isolation. When you do not need this service any longer just stop the container.

## Dependencies
This container requires the host to run pipewire and wireplumber.

## Persistently running
Pipewire and wireplumber run in userspace and are stopped when you logout. So the user needs to stay logged in and it is not just suficient to keep a process open (screen, tmux, byobu, ...). If you want to run this service headless persistently you could enable auto login.

### Manually

```
sudo systemctl edit getty@tty1.service
```

and insert (replacing $USERNAME with your own):

```
[Service]
ExecStart=
ExecStart=-/sbin/agetty --noissue --autologin $USERNAME %I $TERM
Type=idle
```

### When running RaspbianOS
Start `raspi-config` utility and navigate:
- *1 System Options*
  - *S5 Boot / Auto Login*
    - *B2 Console Autologin*

## docker compose
Create a websync folder with empty wsdata.json file if you want to store a copy of your data.
```
services:
  bluetooth_speaker:
    image: gibbz/bluetooth-speaker:latest
    container_name: "bluetooth-speaker"
    hostname: "bluetooth_speaker"
    command: "--single-connection" # optional
    volumes:
      - "/var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket"
    restart: unless-stopped
```

## dockerfile build notes

### To build from Dockerfile
```docker build -t gibbz/bluetooth_speaker .```

### Open an image for browsing
```docker run -i -t gibbz/bluetooth_speaker /bin/sh```

### Connect to a container
```docker container exec -it debug /bin/sh```

### Tag for dockerhub
This will be tagged when the above build is done also.
```docker tag bluetooth_speaker:latest gibbz/bluetooth_speaker:latest```

### Push to dockerhub
```docker push gibbz/bluetooth_speaker:latest```
