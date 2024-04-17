import 'dart:io';

import 'package:moolax_server/middleware.dart';
import 'package:moolax_server/route_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(rejectBadRequests())
      .addMiddleware(authorization())
      .addHandler(router.call);
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
