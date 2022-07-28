## Build & run
```bash
docker build -t anisette provision/
docker run -p 6969:6969 anisette
```

## How to extract lib folder
Steps:
- Download: https://www.apkmirror.com/apk/apple/apple-music/apple-music-3-10-1-release/apple-music-3-10-1-android-apk-download/
- Extract the apk contents
- Tar `lib` folder into libs.tar.gz: `tar -czf libs.tar.gz lib/`
  
> Optional: Just `libstoreservicescore.so` and `libCoreADI.so` are needed, everything else can be removed. (https://github.com/Dadoum/Provision)