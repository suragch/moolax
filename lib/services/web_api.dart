/// Copyright (c) 2019 Razeware LLC
/// See LICENSE for details.

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:moolax/core/rate.dart';
import 'package:http/http.dart' as http;

// This is the contract that all WebApi services must follow. Using an abstract
// class like this allows you to swap concrete implementations. This is useful
// for separating architectural layers. It also makes testing and development
// easier because you can provide a mock implementation or fake data.
abstract class WebApi {
  Future<List<Rate>> fetchExchangeRates();
}

// This class is the concrete implementation of [WebApi]. It contains the logic
// to get the exchange rate data from api.exchangeratesapi.io. However, no other
// class in the app knows that, so if you wanted to swap out a different web API,
// this is the only place you would need to make the change.
class WebApiImpl implements WebApi {
  final _host = 'moolaxworker.studymongolian.workers.dev';
  final _path = 'api';
  final Map<String, String> _headers = {'Accept': 'application/json'};

  List<Rate>? _rateCache;

  Future<List<Rate>> fetchExchangeRates() async {
    if (_rateCache == null) {
      print('getting rates from the web');
      final uri = Uri.https(_host, _path);
      final results = await http.get(uri, headers: _headers);
      final jsonObject = json.decode(results.body);
      _rateCache = _createRateListFromRawMap(jsonObject);
    } else {
      print('getting rates from cache');
    }
    return _rateCache ?? [];
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
