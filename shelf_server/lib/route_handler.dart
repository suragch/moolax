import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'secrets.dart';

final router = Router()..get('/', _handler);

String? _fxCache;
DateTime? _cacheDate;

final _headers = {
  'Content-Type': 'application/json',
};

Future<Response> _handler(Request req) async {
  if (_isCacheValid()) {
    print('Using cache');
    return Response.ok(_fxCache, headers: _headers);
  }

  print('contacting fixer.io');
  final url = 'http://data.fixer.io/api/latest?access_key=$fixerAccessKey';
  final response = await http.get(Uri.parse(url));
  final responseBody = response.body;
  if (response.statusCode != 200) {
    print('fixer.io error: $responseBody');
    return Response(
      500,
      body: 'Third-party server failed with status ${response.statusCode}.',
    );
  }
  final data = json.decode(responseBody);
  final success = data['success'];
  if (!success) {
    return Response(
      500,
      body: 'Error: ${json.encode(data['error'])}',
    );
  }
  _fxCache = responseBody;
  _cacheDate = DateTime.now();
  print('updated caches from server. This should happen only once a day max.');
  return Response.ok(_fxCache, headers: _headers);
}

bool _isCacheValid() {
  final oldDate = _cacheDate;
  if (_fxCache == null || oldDate == null) {
    return false;
  }
  final now = DateTime.now();
  final difference = now.difference(oldDate);
  return difference.inHours < 24;
}
