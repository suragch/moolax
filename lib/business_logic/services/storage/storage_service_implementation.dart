/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'dart:convert';
import 'package:moolax/business_logic/models/currency.dart';
import 'package:moolax/business_logic/models/rate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_service.dart';



class StorageServiceImpl implements StorageService {

  static const sharedPrefExchangeRateKey = 'exchange_rate_key';
  static const sharedPrefCurrencyKey = 'currency_key';
  static const sharedPrefLastCacheTimeKey = 'cache_time_key';

  @override
  Future<List<Rate>> getExchangeRateData() async {
    String data = await _getStringFromPreferences(sharedPrefExchangeRateKey);
    List<Rate> rates = _deserializeRates(data);
    return Future<List<Rate>>.value(rates);
  }

  @override
  Future<void> cacheExchangeRateData(List<Rate> data) {
    String jsonString = jsonEncode(data);
    _saveToPreferences(sharedPrefExchangeRateKey, jsonString);
    _resetCacheTimeToNow();
    return null;
  }

  @override
  Future<List<Currency>> getFavoriteCurrencies() async {
    String data = await _getStringFromPreferences(sharedPrefCurrencyKey);
    if (data == '') {
      return [];
    }
    return _deserializeCurrencies(data);
  }

  @override
  Future<void> saveFavoriteCurrencies(List<Currency> data) {
    String jsonString = _serializeCurrencies(data);
    return _saveToPreferences(sharedPrefCurrencyKey, jsonString);
  }

  @override
  Future<bool> isExpiredCache() async {
    final now = DateTime.now();
    DateTime lastUpdate = await _getLastRatesCacheTime();
    Duration difference = now.difference(lastUpdate);
    return difference.inDays > 1;
  }

  List<Rate> _deserializeRates(String data) {
    List<Map> rateList = jsonDecode(data);
    return rateList.map((rateMap) {
      Rate.fromJson(rateMap);
    }).toList();
  }

  List<Currency> _deserializeCurrencies(String data) {
    List<String> codeList = jsonDecode(data);
    return codeList.map((code) {
      Currency(code);
    }).toList();
  }

  String _serializeCurrencies(List<Currency> data) {
    final currencies =
    data.map((currency) => currency.isoCode).toList();
    return jsonEncode(currencies);
  }

  Future<void> _saveToPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> _getStringFromPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future<String>.value(prefs.getString(key) ?? '');
  }

  Future<void> _resetCacheTimeToNow() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(sharedPrefLastCacheTimeKey, timestamp);
  }

  Future<DateTime> _getLastRatesCacheTime() async {
    final prefs = await SharedPreferences.getInstance();
    int timestamp = prefs.getInt(sharedPrefLastCacheTimeKey) ?? 0;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
}
