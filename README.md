# **TODO App using gRPC**
## A simple way to synchronize TODO Lists between devices using gRPC communication. Frontend and Backend built with flutter & dart 💙
* Flutter v3.10 and Dart 3
---

## Getting Started 🚀

_*** To run the project, either use the launch configuration in VSCode Studio or execute the following commands_


### First, it's necessary to run the server before running the App 👇

![server-running]
 
```sh
 $  dart server/bin/server.dart 
```
### Then run on your favorite device or emulator 👇

![client-running]

```sh
 $  cd client
 $  flutter run -d emulator-5556
```
If you want to check the sync feature, simply open another terminal tab and run it on another device

```sh
 $  cd client
 $  flutter run -d emulator-XPTO
```

### If it is necessary to make changes to the `.proto` file, you just need to generate the files as follows:

```sh
 $  cd protos/lib
 $  protoc --dart_out=grpc:src/generated -Iprotos protos/*  
```

---

### Quick Demo:
![demo]

---
### Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].


[server-running]: client/readme-assets/server.png
[client-running]: client/readme-assets/client.png
[demo]: client/readme-assets/demo-final.gif
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/
[internationalization_link]: https://flutter.dev/docs/development/