# dynamic_bounce

A new Flutter project.

## Getting Started

This project uses Firebase.

Please create a new Firebase project for development.

Edit "flutterfire-config.sh" and input the ID of the newly created Firebase project in the --project parameter.

Execute the following command.

```
./flutterfire-config.sh dev
```

Select "Build configuration".

```
? You have to choose a configuration type. Either build configuration (most likely choice) or a target set up. ›
❯ Build configuration
  Target
```

Choose the Debug-dev build configuration.

```
? Please choose one of the following build configurations ›
❯ Debug-dev
  Profile-dev
  Release-dev
  Debug-prod
  Profile-prod
  Release-prod
```

Choose the platforms you want to configure.

```
? Which platforms should your configuration support (use arrow keys & space to select)? ›
  android
✔ ios
  macos
  web
  windows
```

[reference URL](https://codewithandrea.com/articles/flutter-firebase-multiple-flavors-flutterfire-cli/)

This project uses flavor.
Please execute the following commnd in development.

```
flutter run --flavor dev
```
