## AltServerd (AltServer Docker)
Docker & docker-compose solutions for the combo [AltServer](https://github.com/NyaMisty/AltServer-Linux) and [netmuxd](https://github.com/jkcoxson/netmuxd). It provides an environment to build **netmuxd** and also an image/docker-compose to run everything in its own environment with all the dependencies met.

### Pre-Requisites (DietPi)
Following packages need to be installed:
- Docker
- Docker Compose
- Git
- Avahi-daemon

### Run via Docker
```bash
# To enter in "config" mode to pair a device with "usbmuxd"
# Will run bash inside prepared environment
docker-compose run config

# To bring up AltServer
# Recomendation: First refresh via USB
docker-compose up -d altserver

# To build netmuxd
docker-compose run netmuxd
```
> You can use this repo with **[powenn/AltServer-Linux-ShellScript](https://github.com/powenn/AltServer-Linux-ShellScript)**. **@powenn** has implemented wifi refresh for *x86_64* but not for other platforms as [netmuxd](https://github.com/jkcoxson/netmuxd/releases) is not built by **@jkcoxson** for all the platforms. Using this repo and its dockerfile (see above) you can build **netmuxd** for your environment and use 
[x64-run.sh](https://raw.githubusercontent.com/powenn/AltServer-Linux-ShellScript/main/x64-run.sh) script from @powenn repo to have wifi refresh.

### TODO
- Split `usbmuxd` into separated container (one-time continer) and share across the volume `/var/lib/lockdown` where the keys are stored.

## Credits
- https://github.com/NyaMisty/AltServer-Linux @NyaMisty
- https://github.com/Dadoum/Provision @Dodaum
- https://github.com/jkcoxson/netmuxd @jkcoxson
