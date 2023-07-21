/// Copyright (c) 2019 Razeware LLC
/// See LICENSE for details.

import 'package:moolax/core/currency.dart';
import 'package:moolax/core/rate.dart';
import 'package:moolax/services/service_locator.dart';
import 'package:moolax/services/storage_service.dart';
import 'package:moolax/services/web_api.dart';

abstract class CurrencyService {
  Future<List<Rate>> getAllExchangeRates({String base});
  Future<List<Currency>> getFavoriteCurrencies();
  Future<void> saveFavoriteCurrencies(List<Currency> data);
  void Function(Duration)? staleCacheListener;
}

class CurrencyServiceImpl implements CurrencyService {
  WebApi _webApi = getIt<WebApi>();
  StorageService _storageService = getIt<StorageService>();

  static final defaultFavorites = [Currency('EUR'), Currency('USD')];

  List<Rate>? _rateCache;

  @override
  void Function(Duration p1)? staleCacheListener;

  @override
  Future<List<Rate>> getAllExchangeRates({String? base}) async {
    // use the in-memory cache first
    var rates = _rateCache;
    if (rates != null) {
      return _convertBaseCurrency(base, rates);
    }

    // look it up in storage next
    final lapsedTime = await _storageService.timeSinceLastRatesCache();
    if (lapsedTime.inHours <= 24) {
      rates = await _storageService.getExchangeRateData();
      if (rates != null) {
        _rateCache = rates;
        return _convertBaseCurrency(base, rates);
      }
    }

    // look it up on the web
    rates = await _webApi.fetchExchangeRates();
    if (rates != null) {
      _storageService.cacheExchangeRateData(rates);
      _rateCache = rates;
      return _convertBaseCurrency(base, rates);
    }

    // return stale cache if necessary
    rates = await _storageService.getExchangeRateData();
    if (rates != null) {
      if (lapsedTime.inDays > 30) {
        // notify the user that the exchange rate data is old
        staleCacheListener?.call(lapsedTime);
      }
      _rateCache = rates;
      return _convertBaseCurrency(base, rates);
    }

    // return an empty list as a last resort
    return [];
  }

  @override
  Future<List<Currency>> getFavoriteCurrencies() async {
    final favorites = await _storageService.getFavoriteCurrencies();
    if (favorites.isEmpty) {
      return defaultFavorites;
    }
    return favorites;
  }

  List<Rate> _convertBaseCurrency(String? base, List<Rate> remoteData) {
    if (base == null || remoteData.isEmpty) return remoteData;
    if (remoteData[0].baseCurrency == base) {
      return remoteData;
    }
    double divisor = remoteData
        .firstWhere((rate) => rate.quoteCurrency == base)
        .exchangeRate;
    return remoteData
        .map((rate) => Rate(
              baseCurrency: base,
              quoteCurrency: rate.quoteCurrency,
              exchangeRate: rate.exchangeRate / divisor,
            ))
        .toList();
  }

  @override
  Future<void> saveFavoriteCurrencies(List<Currency> data) async {
    await _storageService.saveFavoriteCurrencies(data);
  }
}
