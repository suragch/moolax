// Copyright (c) 2019 Razeware LLC
// See LICENSE for details.

import 'dart:developer';

import 'package:http/http.dart';
import 'package:moolax/core/currency.dart';
import 'package:moolax/core/rate.dart';
import 'package:moolax/services/service_locator.dart';
import 'package:moolax/services/storage_service.dart';
import 'package:moolax/services/web_api.dart';

class CurrencyService {
  final _webApi = getIt<WebApi>();
  final _storageService = getIt<StorageService>();

  static final defaultFavorites = [Currency('EUR'), Currency('USD')];

  Map<String, Rate>? _rateCache;

  Future<void> init() async {
    await _storageService.init();
  }

  /// key is quote currency ISO code
  Future<Map<String, Rate>> getAllExchangeRates({
    bool preferWebOverCache = false,
    String? base,
    void Function(String)? onError,
  }) async {
    // Skip the cache if the user has requested fresh data
    if (preferWebOverCache) {
      final rates = await _getRatesFromServer(base: base, onError: onError);
      if (rates != null) {
        _rateCache = rates;
        return rates;
      }
    }

    // Prefer in-memory cache
    var rates = await _getInMemoryCache(base);
    if (rates != null) {
      return rates;
    }

    // If the cache is less than 24 hours old, use it
    final lapsedTime = _storageService.timeSinceLastRatesCache();
    log('Time since last cache: $lapsedTime');
    if (lapsedTime.inHours <= 24) {
      rates = await _getStoredCache(base);
      if (rates != null) {
        _rateCache = rates;
        return rates;
      }
    }

    // look it up on the web
    rates = await _getRatesFromServer(base: base, onError: onError);
    if (rates != null) {
      _rateCache = rates;
      return rates;
    }

    // return stale cache if necessary
    rates = await _getStoredCache(base);
    if (rates != null) {
      _rateCache = rates;
      return rates;
    }

    // return an empty map as a last resort
    log('returning empty map');
    return {};
  }

  Future<Map<String, Rate>?> _getInMemoryCache(String? base) async {
    if (_rateCache != null && _rateCache!.isNotEmpty) {
      log('in-memory cache');
      return _convertBaseCurrency(base, _rateCache!);
    }
    return null;
  }

  Future<Map<String, Rate>?> _getStoredCache(String? base) async {
    final rates = _storageService.getExchangeRateData();
    if (rates != null && rates.isNotEmpty) {
      log('using local storage');
      _rateCache = rates;
      return _convertBaseCurrency(base, rates);
    }
    return null;
  }

  Future<Map<String, Rate>?> _getRatesFromServer({
    String? base,
    void Function(String)? onError,
  }) async {
    log('attempting to connect to the server');
    Map<String, Rate>? rates;
    try {
      rates = await _webApi.fetchExchangeRates();
    } on NoInternetException catch (e) {
      // Don't tell the user. Just use a cached value.
      log('NoInternetException: $e');
      onError?.call('It appears you aren\t connected to the internet.');
    } on ApiException catch (e) {
      log('ApiException: $e');
      onError?.call('The server returned an error code of ${e.statusCode}.');
    } on MalformedDataException catch (e) {
      log('MalformedDataException: $e');
      onError?.call('There was a problem with the data from the server.');
    } on ClientException catch (e) {
      // Don't tell the user. Just use a cached value.
      log('ClientException: $e');
      onError?.call('There was a problem connecting to the internet.');
    }
    if (rates != null && rates.isNotEmpty) {
      log('Successfully fetched rates from the server');
      await _storageService.cacheExchangeRateData(rates);
      _rateCache = rates;
      return _convertBaseCurrency(base, rates);
    }
    return null;
  }

  Future<List<Currency>> getFavoriteCurrencies() async {
    final favorites = _storageService.getFavoriteCurrencies();
    if (favorites.isEmpty) {
      return defaultFavorites;
    }
    return favorites;
  }

  Map<String, Rate> _convertBaseCurrency(
    String? base,
    Map<String, Rate> remoteData,
  ) {
    if (base == null || remoteData.isEmpty) return remoteData;
    final baseRate = remoteData[base]!;
    if (baseRate.baseCurrency == base) {
      return remoteData;
    }
    final divisor = baseRate.exchangeRate;
    return remoteData.map(
      (quoteIso, rate) => MapEntry(
        quoteIso,
        Rate(
          baseCurrency: base,
          quoteCurrency: quoteIso,
          exchangeRate: rate.exchangeRate / divisor,
        ),
      ),
    );
  }

  Future<void> saveFavoriteCurrencies(List<Currency> data) async {
    await _storageService.saveFavoriteCurrencies(data);
  }
}
