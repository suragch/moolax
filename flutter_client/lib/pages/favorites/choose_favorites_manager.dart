// Copyright (c) 2019 Razeware LLC
// See LICENSE for details.

import 'package:flutter/foundation.dart';
import 'package:moolax/core/currency.dart';
import 'package:moolax/core/rate.dart';
import 'package:moolax/services/currency_service.dart';
import 'package:moolax/core/iso_data.dart';
import 'package:moolax/services/iap_service.dart';
import 'package:moolax/services/service_locator.dart';

class ChooseFavoritesManager {
  final _currencyService = getIt<CurrencyService>();
  final favoritesNotifier = FavoritesNotifier();

  List<Currency> _favorites = [];

  void loadData() async {
    final rates = await _currencyService.getAllExchangeRates();
    _favorites = await _currencyService.getFavoriteCurrencies();
    final initialList = _prepareChoicePresentation(rates);
    favoritesNotifier.init(initialList);
  }

  List<FavoritePresentation> _prepareChoicePresentation(Map<String, Rate> rates) {
    final iapService = getIt<IapService>();
    List<FavoritePresentation> list = [];
    for (final rate in rates.values) {
      String code = rate.quoteCurrency;
      bool isFavorite = _getFavoriteStatus(code);
      list.add(FavoritePresentation(
        flag: IsoData.flagOf(code),
        isoCode: code,
        longName: IsoData.longNameOf(code),
        isFavorite: isFavorite,
        showBanner: IsoData.isPro(code) && !iapService.hasPro,
      ));
    }
    list.sort((a, b) {
      // Show free currencies before pro currencies
      if (a.showBanner != b.showBanner) {
        return a.showBanner ? 1 : -1;
      }
      // Then sort alphabetically
      return a.isoCode.compareTo(b.isoCode);
    });
    return list;
  }

  bool _getFavoriteStatus(String code) {
    for (Currency currency in _favorites) {
      if (code == currency.isoCode) return true;
    }
    return false;
  }

  void toggleFavoriteStatus(String isoCode) {
    final isFavorite = favoritesNotifier.toggleFavorite(isoCode);

    // update favorite list
    if (isFavorite) {
      _addToFavorites(isoCode);
    } else {
      _removeFromFavorites(isoCode);
    }
  }

  void _addToFavorites(String alphabeticCode) {
    _favorites.add(Currency(alphabeticCode));
    _currencyService.saveFavoriteCurrencies(_favorites);
  }

  void _removeFromFavorites(String alphabeticCode) {
    for (final currency in _favorites) {
      if (currency.isoCode == alphabeticCode) {
        _favorites.remove(currency);
        break;
      }
    }
    _currencyService.saveFavoriteCurrencies(_favorites);
  }

  void search(String text) {
    favoritesNotifier.filter(text);
  }
}

class FavoritePresentation {
  final String flag;
  final String isoCode;
  final String longName;
  final bool isFavorite;
  final bool showBanner;

  FavoritePresentation({
    required this.flag,
    required this.isoCode,
    required this.longName,
    required this.isFavorite,
    required this.showBanner,
  });
}

class FavoritesNotifier extends ValueNotifier<List<FavoritePresentation>> {
  FavoritesNotifier() : super([]);

  late List<FavoritePresentation> _fullList;

  void init(List<FavoritePresentation> initialList) {
    _fullList = initialList;
    value = initialList;
  }

  void refresh() {
    notifyListeners();
  }

  bool toggleFavorite(String isoCode) {
    final choiceIndex = _fullList.indexWhere(
      (element) => element.isoCode == isoCode,
    );
    final item = _fullList[choiceIndex];
    final isFavorite = !item.isFavorite;
    _fullList[choiceIndex] = FavoritePresentation(
      flag: item.flag,
      isoCode: item.isoCode,
      longName: item.longName,
      isFavorite: isFavorite,
      showBanner: item.showBanner,
    );
    filter(_filter);
    notifyListeners();
    return isFavorite;
  }

  String _filter = '';

  void filter(String search) {
    if (search.isEmpty) {
      value = _fullList;
      return;
    }
    final cleaned = search.trim().toUpperCase();
    _filter = cleaned;
    value = _fullList
        .where(
          (element) => element.isoCode.contains(cleaned) || element.longName.toUpperCase().contains(cleaned),
        )
        .toList();
  }
}
