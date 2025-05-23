// Copyright (c) 2019 Razeware LLC
// See LICENSE for details.

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:moolax/core/currency.dart';
import 'package:moolax/core/rate.dart';
import 'package:moolax/services/currency_service.dart';
import 'package:moolax/core/iso_data.dart';
import 'package:moolax/services/service_locator.dart';
import 'package:moolax/services/storage_service.dart';

enum RefreshState { hidden, showingButton, refreshing }

class CalculateScreenManager extends ChangeNotifier {
  var refreshState = RefreshState.hidden;
  // final updateNotifier = ValueNotifier<String>('');
  String refreshDate = '';

  void Function(String)? onNetworkError;
  final _currencyService = getIt<CurrencyService>();
  final _storageService = getIt<StorageService>();

  CurrencyPresentation _baseCurrency = defaultBaseCurrency;
  List<CurrencyPresentation> _quoteCurrencies = [];
  Map<String, Rate> _rates = {};

  static final defaultBaseCurrency = CurrencyPresentation(
    flag: '',
    isoCode: '',
    longName: '',
    amount: '',
  );

  Future<void> loadData() async {
    await _loadCurrencies();
    notifyListeners();
    _rates = await _currencyService.getAllExchangeRates(
      base: _baseCurrency.isoCode,
    );
    refreshDate = _formatCacheDate(_storageService.lastCacheDate);
    if (_rates.isEmpty) {
      onNetworkError?.call('There was a problem fetching the exchange rates '
          'from the server. Try again later.');
      refreshState = RefreshState.showingButton;
    } else {
      refreshState = RefreshState.hidden;
    }
    notifyListeners();
  }

  String _formatCacheDate(DateTime date) {
    return 'Updated: ${DateFormat('yyyy-MM-dd').format(date)}';
  }

  Future<void> forceRefresh() async {
    refreshState = RefreshState.refreshing;
    notifyListeners();
    await _currencyService.purgeLocalCache();
    await loadData();
  }

  Future<void> _loadCurrencies() async {
    final currencies = await _currencyService.getFavoriteCurrencies();
    _baseCurrency = _loadBaseCurrency(currencies);
    _quoteCurrencies = _loadQuoteCurrencies(currencies);
  }

  CurrencyPresentation _loadBaseCurrency(List<Currency> currencies) {
    if (currencies.isEmpty) {
      return defaultBaseCurrency;
    }
    String code = currencies[0].isoCode;
    return CurrencyPresentation(
      flag: IsoData.flagOf(code),
      isoCode: code,
      longName: IsoData.longNameOf(code),
      amount: '',
    );
  }

  List<CurrencyPresentation> _loadQuoteCurrencies(List<Currency> currencies) {
    List<CurrencyPresentation> quotes = [];
    for (int i = 1; i < currencies.length; i++) {
      String code = currencies[i].isoCode;
      quotes.add(CurrencyPresentation(
        flag: IsoData.flagOf(code),
        isoCode: code,
        longName: IsoData.longNameOf(code),
        amount: 0.toStringAsFixed(2),
      ));
    }
    return quotes;
  }

  CurrencyPresentation get baseCurrency {
    return _baseCurrency;
  }

  List<CurrencyPresentation> get quoteCurrencies {
    return _quoteCurrencies;
  }

  void calculateExchange(String baseAmount) async {
    double amount;
    try {
      amount = double.parse(baseAmount);
    } on FormatException {
      amount = 0;
    }
    _updateCurrenciesFor(amount);
    notifyListeners();
  }

  void _updateCurrenciesFor(double baseAmount) {
    final formatter = NumberFormat.decimalPatternDigits(
      locale: 'en_us',
      decimalDigits: 2,
    );
    for (final currency in _quoteCurrencies) {
      final rate = _rates[currency.isoCode]?.exchangeRate ?? 0.0;
      currency.amount = formatter.format(baseAmount * rate);
    }
  }

  Future<void> refreshFavorites(String amount) async {
    await _loadCurrencies();
    calculateExchange(amount);
  }

  Future<void> setNewBaseCurrency(int quoteCurrencyIndex) async {
    final oldBaseCurrency = _baseCurrency;
    _baseCurrency = _quoteCurrencies[quoteCurrencyIndex];
    _quoteCurrencies.removeAt(quoteCurrencyIndex);
    _quoteCurrencies.insert(0, oldBaseCurrency);
    final wholeList = _convertPresentationToCurrency();
    await _currencyService.saveFavoriteCurrencies(wholeList);
    loadData();
  }

  List<Currency> _convertPresentationToCurrency() {
    List<Currency> currencies = [];
    currencies.add(Currency(_baseCurrency.isoCode));
    for (CurrencyPresentation currency in _quoteCurrencies) {
      currencies.add(Currency(currency.isoCode));
    }
    return currencies;
  }

  Future<void> unfavorite(String isoCode) async {
    final favorites = await _currencyService.getFavoriteCurrencies();
    favorites.removeWhere((currency) => currency.isoCode == isoCode);
    _currencyService.saveFavoriteCurrencies(favorites);
    _quoteCurrencies.removeWhere((currency) => currency.isoCode == isoCode);
  }
}

// A model class specifically for displaying data in a view. Everything is a
// preformatted string.
class CurrencyPresentation {
  final String flag;
  final String isoCode;
  final String longName;
  String amount;

  CurrencyPresentation({
    required this.flag,
    required this.isoCode,
    required this.longName,
    required this.amount,
  });

  @override
  String toString() {
    return '($isoCode, $amount)';
  }
}
