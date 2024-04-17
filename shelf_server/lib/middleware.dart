import 'package:moolax_server/secrets.dart';
import 'package:shelf/shelf.dart';

Middleware rejectBadRequests() {
  return (Handler innerHandler) {
    return (Request request) {
      if (request.method != 'GET') {
        return Response(405, body: 'Method not allowed');
      }
      return innerHandler(request);
    };
  };
}

Middleware authorization() {
  return (Handler innerHandler) {
    return (Request request) {
      final authHeader = request.headers['authorization'];
      if (authHeader == null) {
        return Response(401, body: 'Unauthorized');
      }
      final parts = authHeader.split(' ');
      if (parts.length != 2 || parts[0] != 'Bearer') {
        return Response(401, body: 'Unauthorized');
      }
      final apiKey = parts[1];
      if (apiKey != clientApiKey) {
        return Response(403, body: 'Invalid API key');
      }
      return innerHandler(request);
    };
  };
}
