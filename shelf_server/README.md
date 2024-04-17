Moola X server app built using [Shelf](https://pub.dev/packages/shelf).

## Setup

Create a file called `lib/secrets.dart`:

```dart
const clientApiKey = '<client secret>';
const fixerAccessKey = '<fixer access key>';
```

## Running with the Dart SDK

You can run the project like this:

```
$ dart run bin/server.dart
Server listening on port 8080
```