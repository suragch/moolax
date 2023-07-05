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
}

class CurrencyServiceImpl implements CurrencyService {
  WebApi _webApi = getIt<WebApi>();
  StorageService _storageService = getIt<StorageService>();

  static final defaultFavorites = [Currency('EUR'), Currency('USD')];

  @override
  Future<List<Rate>> getAllExchangeRates({String? base}) async {
    List<Rate> webData = await _webApi.fetchExchangeRates();
    if (base != null) {
      return _convertBaseCurrency(base, webData);
    }
    return webData;
  }

  @override
  Future<List<Currency>> getFavoriteCurrencies() async {
    final favorites = await _storageService.getFavoriteCurrencies();
    if (favorites.isEmpty) {
      return defaultFavorites;
    }
    return favorites;
  }

  List<Rate> _convertBaseCurrency(String base, List<Rate> remoteData) {
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
