### Build & run
```bash
docker build -t anisette provision/
docker run -p 6969:6969 anisette
```

### How to extract lib folder
For `anisette` to run, we need some libraries already built for linux (android) present in the Apple Music APK. The steps to extrack them are the following:
- Download: https://www.apkmirror.com/apk/apple/apple-music/apple-music-3-10-1-release/apple-music-3-10-1-android-apk-download/
- Extract the apk contents: `unzip app.apk`
- Tar `lib` folder into libs.tar.gz: `tar -czf libs.tar.gz lib/`

> Optional: According to [Provision](https://github.com/Dadoum/Provision), just `libstoreservicescore.so` and `libCoreADI.so` are needed, everything else can be removed. 
