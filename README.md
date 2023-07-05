# **TODO App using gRPC**
## Frontend and Backend built with flutter 💙
* flutter v3.10 and dart 3
---

## Getting Started 🚀

_*** To run the project either use the launch configuration in VSCode Studio or use the following commands._


### Firstly, It's necessary to run the server before the App 👇

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
If you want to check the sync feature, just open another terminal tab and run on other device

```sh
$  cd client
$  flutter run -d emulator-XPTO
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