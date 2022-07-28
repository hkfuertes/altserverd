# AltServer Docker (Wifi)
Steps:
- Compile netmuxd:
  ```bash
  docker build -t netmuxd netmuxd/
  docker run -v netmuxd:/build netmuxd
  ```

- Compile & run anisette:
  ```bash
  docker build -t anisette provision/
  docker run -p 6969:6969 anisette
  ```


> Following this [guide](https://www.reddit.com/r/jailbreak/comments/wa4z2z/tutorial_altstore_wifi_refresh_on_raspberry_pi/)


> `docker buildx build --platform=linux/amd64,linux/arm64` ?