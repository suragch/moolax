// Copyright (c) 2019 Razeware LLC
// See LICENSE for details.

import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:moolax/core/rate.dart';
import 'package:http/http.dart' as http;
import 'package:moolax/secrets.dart';

class WebApi {
  final _host = 'https://moolax.suragch.dev';
  // String get _host =>
  //     Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://127.0.0.1:8080';
  final _path = 'api';
  final Map<String, String> _headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${AppSecrets.webApiKey}',
  };

  Map<String, Rate>? _rateCache;

  /// returns null for any internet problems
  Future<Map<String, Rate>?> fetchExchangeRates() async {
    // use in-memory cache if available
    final rates = _rateCache;
    if (rates != null) {
      log('getting rates from cache');
      return rates;
    }

    // check the network connection
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      log('No Internet connection');
      return null;
    }

    // look the data up on the server
    log('getting rates from the web');
    final uri = Uri.parse('$_host/$_path');
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      log('Unexpected status code: ${response.statusCode}');
      log(response.body);
      return null;
    }

    // extract the data
    log(response.body);
    try {
      final jsonObject = json.decode(response.body);
      _rateCache = _createRateListFromRawMap(jsonObject);
    } on FormatException {
      log('Server data malformatted');
      return null;
    }

    return _rateCache;
  }

  Map<String, Rate> _createRateListFromRawMap(dynamic jsonObject) {
    final rates = jsonObject['rates'] as Map<String, dynamic>;
    final base = jsonObject['base'] as String;
    return rates.map(
      (quote, rate) => MapEntry(
        quote,
        Rate(
          baseCurrency: base,
          quoteCurrency: quote,
          exchangeRate: (rate as num).toDouble(),
        ),
      ),
    );
  }

  void purgeInMemoryCache() {
    _rateCache = null;
  }
}
