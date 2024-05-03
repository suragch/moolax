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

## Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker build . -t myserver
$ docker run -it -p 8080:8080 myserver
Server listening on port 8080
```

And then from a second terminal:
```
$ curl -H "Authorization: Bearer <api token>" http://localhost:8080/
```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:04.620417  0:00:00.000158 GET     [200] /
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /echo/I_love_Dart
```