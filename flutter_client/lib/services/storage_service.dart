// Copyright (c) 2019 Razeware LLC
// See LICENSE for details.

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:moolax/core/currency.dart';
import 'package:moolax/core/rate.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  Future<void> init();
  Future<void> cacheExchangeRateData(Map<String, Rate> data);
  Map<String, Rate>? getExchangeRateData();
  List<Currency> getFavoriteCurrencies();
  Future<void> saveFavoriteCurrencies(List<Currency> data);
  Duration timeSinceLastRatesCache();
  Future<void> purgeLocalCache();
}

class StorageServiceImpl implements StorageService {
  static const _exchangeRateKey = 'exchange_rate_key';
  static const _favoriteCurrencyKey = 'currency_key';
  static const _lastCacheTimeKey = 'cache_time_key';

  late SharedPreferences prefs;

  @override
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Map<String, Rate>? getExchangeRateData() {
    final data = prefs.getString(_exchangeRateKey);
    if (data == null) return null;
    return _deserializeRates(data);
  }

  Map<String, Rate>? _deserializeRates(String json) {
    final rates = <String, Rate>{};
    try {
      final rateList = jsonDecode(json);
      if (rateList is! List) return rates;
      for (final item in rateList) {
        final rate = Rate.fromJson(item as Map<String, dynamic>);
        rates[rate.quoteCurrency] = rate;
      }
    } on FormatException {
      debugPrint('JSON format exception');
      return null;
    }
    return rates;
  }

  @override
  Future<void> cacheExchangeRateData(Map<String, Rate> data) async {
    List<Map<String, dynamic>> list = [];
    for (final key in data.keys) {
      final rate = data[key]?.toJson();
      if (rate != null) {
        list.add(rate);
      }
    }
    //final list = data.map((rate) => rate.toJson()).toList();
    String jsonString = jsonEncode(list);
    await prefs.setString(_exchangeRateKey, jsonString);
    _resetCacheTimeToNow();
  }

  @override
  List<Currency> getFavoriteCurrencies() {
    final data = prefs.getString(_favoriteCurrencyKey);
    if (data == null) {
      return [];
    }
    print('getFavoriteCurrencies: $data');
    return _deserializeCurrencies(data);
  }

  List<Currency> _deserializeCurrencies(String json) {
    List<Currency> list = [];
    try {
      final codeList = jsonDecode(json);
      if (codeList is! List) return list;
      for (final code in codeList) {
        if (code is! String) continue;
        list.add(Currency(code));
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return list;
  }

  @override
  Future<void> saveFavoriteCurrencies(List<Currency> data) async {
    String jsonString = _serializeCurrencies(data);
    await prefs.setString(_favoriteCurrencyKey, jsonString);
  }

  String _serializeCurrencies(List<Currency> data) {
    final currencies = data.map((currency) => currency.isoCode).toList();
    return jsonEncode(currencies);
  }

  @override
  Duration timeSinceLastRatesCache() {
    int timestamp = prefs.getInt(_lastCacheTimeKey) ?? 0;
    DateTime lastUpdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    return now.difference(lastUpdate);
  }

  Future<void> _resetCacheTimeToNow() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_lastCacheTimeKey, timestamp);
  }

  @override
  Future<void> purgeLocalCache() async {
    await prefs.remove(_lastCacheTimeKey);
    await prefs.remove(_exchangeRateKey);
  }
}
