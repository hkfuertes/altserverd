# AltServer Docker (Wifi)
Steps:
- Build netmuxd: `docker-compose up netmuxd`
- Build & run anisette: `docker-compose up anisette`

## Using ShellScript
- Download the package from: https://github.com/powenn/AltServer-Linux-ShellScript
- Build netmuxd
- Copy `runtime/start.sh` and `netmuxd` to extracted folder from first step.
- Run `start.sh`