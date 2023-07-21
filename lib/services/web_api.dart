/// Copyright (c) 2019 Razeware LLC
/// See LICENSE for details.

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:moolax/core/rate.dart';
import 'package:http/http.dart' as http;
import 'package:moolax/secrets.dart';

abstract class WebApi {
  Future<List<Rate>?> fetchExchangeRates();
}

class WebApiImpl implements WebApi {
  final _host = 'moolax.suragch.dev';
  final _path = 'api';
  final Map<String, String> _headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${AppSecrets.webApiKey}',
  };

  List<Rate>? _rateCache;

  /// returns null for any internet problems
  Future<List<Rate>?> fetchExchangeRates() async {
    // use in-memory cache if available
    final rates = _rateCache;
    if (rates != null) {
      print('getting rates from cache');
      return rates;
    }

    // check the network connection
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print('No Internet connection');
      return null;
    }

    // look the data up on the server
    print('getting rates from the web');
    final uri = Uri.https(_host, _path);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      print('Unexpected status code: ${response.statusCode}');
      return null;
    }

    // extract the data
    try {
      final jsonObject = json.decode(response.body);
      _rateCache = _createRateListFromRawMap(jsonObject);
    } on FormatException {
      print('Server data malformatted');
      return null;
    }

    return _rateCache;
  }

  List<Rate> _createRateListFromRawMap(dynamic jsonObject) {
    final rates = jsonObject['rates'];
    List<Rate> list = [];

    if (rates is! Map<String, dynamic>) return list;

    final base = jsonObject['base'] as String;
    for (final entry in rates.entries) {
      final quote = entry.key;
      try {
        final rate = (entry.value as num).toDouble();
        list.add(
          Rate(
            baseCurrency: base,
            quoteCurrency: quote,
            exchangeRate: rate,
          ),
        );
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }

    return list;
  }
}
