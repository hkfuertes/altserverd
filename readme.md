## [WIP] AltServer Wifi (with Docker)
The idea of this project was to create a docker container with everything needed for a wifi refresh altserver instalacion platform independant. To do so, some important tools are built via docker for the platform that this repo will be running from.

To run the refresh via wifi, `netmuxd` need to be present and built for the specific platform. In this case a `docker-compose` file is provided to ease this task.
- Build netmuxd: `docker-compose up netmuxd`

Aditionally, if a custom anisette server is needed to be run, there is another convenience service in the `docker-compose` that will build and run an anisette server on port `6969`
- Build & run anisette: `docker-compose up anisette`

### Run via Docker (Manually for now)
First version of dockerized AltServer. To run (manually for now):
- `docker-compose run config`: this will bring you to a `bash` inside the image, already prepared.
  - Use `usbmuxd` to pair the device.
- `docker-compose up -d altserver` will bring AltServer in wifi listening.

#### TODO:
- Split `usbmuxd` into separated container (1-time continer) and share across the volume `/var/lib/lockdown` where the keys are stored.

### Using powenn/AltServer-Linux-ShellScript
There is a project that already does this exact same thing using a convenience script, but as `netmuxd` is not built by default for all the platforms, its script only supports wifi refresh for `x86_64`. As a way to build is provided for you specific platform, it is possible run the `x86_64` version of their script on our instalation to achieve wifi refresh, to do so:
- Download the [package](https://github.com/powenn/AltServer-Linux-ShellScript/releases) and extract it.
- Build `netmuxd`: `docker-compose up netmuxd`
- Copy [x64-run.sh](https://raw.githubusercontent.com/powenn/AltServer-Linux-ShellScript/main/x64-run.sh) onto the extracted folder.
- Copy built `netmuxd` onto extracted folder.
- Run `x64-run.sh`
