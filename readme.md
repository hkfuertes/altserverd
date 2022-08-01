## [WIP] AltServer Wifi (with Docker)
The idea of this project was to create a docker container with everything needed for a wifi refresh altserver instalacion platform independant. To do so, some important tools are built via docker for the platform that this repo will be running from.

### Run via Docker
```bash
# To enter in "config" mode to pair a device with "usbmuxd"
# Will run bash inside prepared environment
docker-compose run config

# To bring up AltServer
docker-compose up -d altserver

# To build netmuxd
docker-compose run netmuxd

# To start anisette server
# You might need to add the environment vars inside docker-compose for altserver
docker-compose up anisette #
```
#### TODO:
- Split `usbmuxd` into separated container (one-time continer) and share across the volume `/var/lib/lockdown` where the keys are stored.

### Using powenn/AltServer-Linux-ShellScript
There is a project that already does this exact same thing using a convenience script, but as `netmuxd` is not built by default for all the platforms, its script only supports wifi refresh for `x86_64`. As a way to build is provided for you specific platform, it is possible run the `x86_64` version of their script on our instalation to achieve wifi refresh, to do so:
- Download the [package](https://github.com/powenn/AltServer-Linux-ShellScript/releases) and extract it.
- Build `netmuxd`: `docker-compose up netmuxd`
- Copy [x64-run.sh](https://raw.githubusercontent.com/powenn/AltServer-Linux-ShellScript/main/x64-run.sh) onto the extracted folder.
- Copy built `netmuxd` onto extracted folder.
- Run `x64-run.sh`
