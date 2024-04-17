// Copyright (c) 2019 Razeware LLC
// See LICENSE for details.

import 'package:moolax/core/currency.dart';
import 'package:moolax/core/rate.dart';
import 'package:moolax/services/service_locator.dart';
import 'package:moolax/services/storage_service.dart';
import 'package:moolax/services/web_api.dart';

abstract class CurrencyService {
  Future<void> init();
  // key is quote currency ISO code
  Future<Map<String, Rate>> getAllExchangeRates({String base});
  Future<List<Currency>> getFavoriteCurrencies();
  Future<void> saveFavoriteCurrencies(List<Currency> data);
  void Function(Duration)? staleCacheListener;
  Future<void> purgeLocalCache();
}

class CurrencyServiceImpl implements CurrencyService {
  final _webApi = getIt<WebApi>();
  final _storageService = getIt<StorageService>();

  static final defaultFavorites = [Currency('EUR'), Currency('USD')];

  Map<String, Rate>? _rateCache;

  @override
  Future<void> init() async {
    await _storageService.init();
  }

  @override
  void Function(Duration p1)? staleCacheListener;

  @override
  Future<Map<String, Rate>> getAllExchangeRates({String? base}) async {
    // use the in-memory cache first
    var rates = _rateCache;
    if (rates != null && rates.isNotEmpty) {
      print('in-memory cache');
      return _convertBaseCurrency(base, rates);
    }

    // look it up in storage next
    final lapsedTime = _storageService.timeSinceLastRatesCache();
    if (lapsedTime.inHours <= 24) {
      rates = _storageService.getExchangeRateData();
      if (rates != null && rates.isNotEmpty) {
        print('using local storage');
        _rateCache = rates;
        return _convertBaseCurrency(base, rates);
      }
    }

    // look it up on the web
    rates = await _webApi.fetchExchangeRates();
    if (rates != null && rates.isNotEmpty) {
      print('using web');
      _storageService.cacheExchangeRateData(rates);
      _rateCache = rates;
      return _convertBaseCurrency(base, rates);
    }

    // return stale cache if necessary
    rates = _storageService.getExchangeRateData();
    if (rates != null && rates.isNotEmpty) {
      print('using stale cache');
      if (lapsedTime.inDays > 30) {
        // notify the user that the exchange rate data is old
        staleCacheListener?.call(lapsedTime);
      }
      _rateCache = rates;
      return _convertBaseCurrency(base, rates);
    }

    // return an empty map as a last resort
    print('returning empty map');
    return {};
  }

  @override
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

  @override
  Future<void> saveFavoriteCurrencies(List<Currency> data) async {
    await _storageService.saveFavoriteCurrencies(data);
  }

  @override
  Future<void> purgeLocalCache() async {
    _rateCache = null;
    _webApi.purgeInMemoryCache();
    await _storageService.purgeLocalCache();
  }
}
