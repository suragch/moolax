/// Copyright (c) 2019 Razeware LLC
/// See LICENSE for details.

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:moolax/core/currency.dart';
import 'package:moolax/core/rate.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  Future<void> cacheExchangeRateData(List<Rate> data);
  Future<List<Rate>?> getExchangeRateData();
  Future<List<Currency>> getFavoriteCurrencies();
  Future<void> saveFavoriteCurrencies(List<Currency> data);
  Future<Duration> timeSinceLastRatesCache();
}

class StorageServiceImpl implements StorageService {
  static const sharedPrefExchangeRateKey = 'exchange_rate_key';
  static const sharedPrefCurrencyKey = 'currency_key';
  static const sharedPrefLastCacheTimeKey = 'cache_time_key';

  @override
  Future<List<Rate>?> getExchangeRateData() async {
    final data = await _getStringFromPreferences(sharedPrefExchangeRateKey);
    if (data == null) return null;
    return _deserializeRates(data);
  }

  List<Rate>? _deserializeRates(String json) {
    final rates = <Rate>[];
    try {
      final rateList = jsonDecode(json);
      if (rateList is! List<Map<String, dynamic>>) return rates;
      for (final rate in rateList) {
        rates.add(Rate.fromJson(rate));
      }
    } on FormatException {
      debugPrint('JSON format exception');
      return null;
    }
    return rates;
  }

  @override
  Future<void> cacheExchangeRateData(List<Rate> data) async {
    final list = data.map((rate) => rate.toJson()).toList();
    String jsonString = jsonEncode(list);
    _saveToPreferences(sharedPrefExchangeRateKey, jsonString);
    _resetCacheTimeToNow();
  }

  @override
  Future<List<Currency>> getFavoriteCurrencies() async {
    final data = await _getStringFromPreferences(sharedPrefCurrencyKey);
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
  Future<void> saveFavoriteCurrencies(List<Currency> data) {
    String jsonString = _serializeCurrencies(data);
    print('saveFavoriteCurrencies: $jsonString');
    return _saveToPreferences(sharedPrefCurrencyKey, jsonString);
  }

  String _serializeCurrencies(List<Currency> data) {
    final currencies = data.map((currency) => currency.isoCode).toList();
    return jsonEncode(currencies);
  }

  @override
  Future<Duration> timeSinceLastRatesCache() async {
    final prefs = await SharedPreferences.getInstance();
    int timestamp = prefs.getInt(sharedPrefLastCacheTimeKey) ?? 0;
    DateTime lastUpdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    return now.difference(lastUpdate);
  }

  Future<void> _saveToPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String?> _getStringFromPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future<String>.value(prefs.getString(key));
  }

  Future<void> _resetCacheTimeToNow() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(sharedPrefLastCacheTimeKey, timestamp);
  }
}
