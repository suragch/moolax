import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:moolax_server/secrets.dart';
import 'package:test/test.dart';

void main() {
  final port = '8080';
  final host = 'http://0.0.0.0:$port';
  final authHeader = {'authorization': 'Bearer $clientApiKey'};
  late Process p;

  setUp(() async {
    p = await Process.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port},
    );
    // Wait for server to start and print to stdout.
    await p.stdout.first;
  });

  tearDown(() => p.kill());

  test('successful request', () async {
    final response = await get(Uri.parse('$host/api'), headers: authHeader);
    expect(response.statusCode, 200);
    expect(response.body, isNotEmpty);
    final map = json.decode(response.body);
    expect(map['success'], true);
  });

  test('Requests must contain API key', () async {
    var response = await get(Uri.parse('$host/api'));
    expect(response.statusCode, 401);

    response = await get(
      Uri.parse('$host/api'),
      headers: {'authorization': 'Bearer foo'},
    );
    expect(response.statusCode, 403);
  });

  test('POST not allowed', () async {
    final response = await post(Uri.parse('$host/api'));
    expect(response.statusCode, 405);
  });

  test('404', () async {
    final response = await get(Uri.parse('$host/foobar'), headers: authHeader);
    expect(response.statusCode, 404);
  });
}
