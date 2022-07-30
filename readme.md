## AltServer Wifi (with Docker)
The idea of this project was to create a docker container with everything needed for a wifi refresh altserver instalacion platform independant. To do so, some important tools are built via docker for the platform that this repo will be running from.

To run the refresh via wifi, `netmuxd` need to be present and built for the specific platform. In this case a `docker-compose` file is provided to ease this task.
- Build netmuxd: `docker-compose up netmuxd`

Aditionally, if a custom anisette server is needed to be run, there is another convenience service in the `docker-compose` that will build and run an anisette server on port `6969`
- Build & run anisette: `docker-compose up anisette`

### Using powenn/AltServer-Linux-ShellScript
There is a project that already does this exact same thing using a convenience script, but as `netmuxd` is not built by default for all the platforms, its script only supports wifi refresh for `x86_64`. As we provide a way to build for you specific platform, we could run the `x86_64` version of their script on our instalation to achieve wifi refresh, to do so:
- Download the [package](https://github.com/powenn/AltServer-Linux-ShellScript/releases) and extract it.
- Build `netmuxd`: `docker-compose up netmuxd`
- Copy [x64-run.sh](https://raw.githubusercontent.com/powenn/AltServer-Linux-ShellScript/main/x64-run.sh) onto the extracted folder.
- Copy built `netmuxd` onto extracted folder.
- Run `x64-run.sh`

### Using systemd
If you just want to run it serverless, use the following script modified from powenn's. This will create 2 service files that can be enabled in systemd

```bash
# Install dependencies (Asuming RaspberryPi OS)
sudo apt install -y libavahi-compat-libdnssd-dev usbmuxd
# Clone this repo
git clone https://github.com/hkfuertes/alt-server-wifi .
# Run install script
./install.sh
```
