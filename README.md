# APOD - Astronomy Picture of the Day

Generate API Key

- https://api.nasa.gov/

Get the packages

```bash
flutter pub get
```

### Start the APOD App

```bash

flutter pub run build_runner build


flutter create . --platforms android
flutter run --dart-define ApiKey=APOD_API_KEY_HERE
```

### Riverpod v2

- [Getting Started with Riverpod v2](https://docs-v2.riverpod.dev/docs/introduction/getting_started)
