## AltServerd (AltServer Docker)
Docker & docker-compose solutions for the combo [AltServer](https://github.com/NyaMisty/AltServer-Linux) and [netmuxd](https://github.com/jkcoxson/netmuxd). It provides an environment to build **netmuxd** and also an image/docker-compose to run everything in its own environment with all the dependencies met.

### Usage
```bash
# To enter in "config" mode to pair a device with "usbmuxd"
# Will run bash inside prepared environment
docker-compose run config

# To bring up AltServer
# Recomendation: First refresh via USB
docker-compose up -d daemon

# To build netmuxd
docker-compose run netmuxd

# To build altserver
docker-compose run altserver
```
> You can use this repo with **[powenn/AltServer-Linux-ShellScript](https://github.com/powenn/AltServer-Linux-ShellScript)**. **@powenn** has implemented wifi refresh for *x86_64* but not for other platforms as [netmuxd](https://github.com/jkcoxson/netmuxd/releases) is not built by **@jkcoxson** for all the platforms. Using this repo and its dockerfile (see above) you can build **netmuxd** for your environment and use 
[x64-run.sh](https://raw.githubusercontent.com/powenn/AltServer-Linux-ShellScript/main/x64-run.sh) script from @powenn repo to have wifi refresh.

### DietPi Environment Setup
```bash
# docker, docker-compose, git, avahi-daemon
dietpi-software install 162 134 17 152
```

### Raspberry PI OS Environment Setup
```bash
# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
sudo usermod -aG docker $USER # Requires restart/logout for changes to take effect
sudo systemctl enable --now docker
sudo systemctl start docker

# Install git, docker-compose, avahi-daemon
sudo apt update; sudo apt install -y git docker-compose avahi-daemon
```

## Credits
- https://github.com/NyaMisty/AltServer-Linux @NyaMisty - _(Using **tags/v0.0.5**)_
- https://github.com/Dadoum/Provision @Dodaum _(Using **tags/v0.1.2**)_
- https://github.com/jkcoxson/netmuxd @jkcoxson
