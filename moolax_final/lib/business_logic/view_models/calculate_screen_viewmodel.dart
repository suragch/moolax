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

import 'package:flutter/foundation.dart';
import 'package:moolax/business_logic/models/currency.dart';
import 'package:moolax/business_logic/models/rate.dart';
import 'package:moolax/services/currency/currency_service.dart';
import 'package:moolax/business_logic/utils/iso_data.dart';
import 'package:moolax/services/service_locator.dart';

class CalculateScreenViewModel extends ChangeNotifier {
  final CurrencyService _currencyService = serviceLocator<CurrencyService>();

  CurrencyPresentation _baseCurrency = defaultBaseCurrency;
  List<CurrencyPresentation> _quoteCurrencies = [];
  List<Rate> _rates = [];

  static final CurrencyPresentation defaultBaseCurrency = CurrencyPresentation(
      flag: '',
      alphabeticCode: '',
      longName: '',
      amount: ''
  );

  void loadData() async {
    await _loadCurrencies();
    _rates = await _currencyService.getAllExchangeRates(base: _baseCurrency.alphabeticCode);
    notifyListeners();
  }

  Future<void> _loadCurrencies() async {
    final currencies = await _currencyService.getFavoriteCurrencies();
    _baseCurrency = _loadBaseCurrency(currencies);
    _quoteCurrencies = _loadQuoteCurrencies(currencies);
  }

  CurrencyPresentation _loadBaseCurrency(List<Currency> currencies) {
    if (currencies.length == 0) {
      return defaultBaseCurrency;
    }
    String code = currencies[0].isoCode;
    return CurrencyPresentation(
        flag: IsoData.flagOf(code),
        alphabeticCode: code,
        longName: IsoData.longNameOf(code),
        amount: ''
    );
  }

  _loadQuoteCurrencies(List<Currency> currencies) {
    List<CurrencyPresentation> quotes = [];
    for (int i = 1; i < currencies.length; i++) {
      String code = currencies[i].isoCode;
      quotes.add(CurrencyPresentation(
        flag: IsoData.flagOf(code),
        alphabeticCode: code,
        longName: IsoData.longNameOf(code),
        amount: currencies[i].amount.toStringAsFixed(2),
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
    } catch (e) {
      _updateCurrenciesFor(0);
      notifyListeners();
      return null;
    }

    _updateCurrenciesFor(amount);

    notifyListeners();
  }

  void _updateCurrenciesFor(double baseAmount) {
    for (CurrencyPresentation c in _quoteCurrencies) {
      for (Rate r in _rates) {
        if (c.alphabeticCode == r.quoteCurrency) {
          c.amount = (baseAmount * r.exchangeRate).toStringAsFixed(2);
          break;
        }
      }
    }
  }

  Future refreshFavorites() async {
    await _loadCurrencies();
    notifyListeners();
  }

  Future setNewBaseCurrency(int quoteCurrencyIndex) async {
    _quoteCurrencies.add(_baseCurrency);
    _baseCurrency = _quoteCurrencies[quoteCurrencyIndex];
    _quoteCurrencies.removeAt(quoteCurrencyIndex);
    await _currencyService.saveFavoriteCurrencies(_convertPresentationToCurrency());
    loadData();
  }

  List<Currency> _convertPresentationToCurrency() {
    List<Currency> currencies = [];
    currencies.add(Currency(_baseCurrency.alphabeticCode));
    for (CurrencyPresentation currency in _quoteCurrencies) {
      currencies.add(Currency(currency.alphabeticCode));
    }
    return currencies;
  }

}

class CurrencyPresentation {
  final String flag;
  final String alphabeticCode;
  final String longName;
  String amount;

  CurrencyPresentation({
    this.flag,
    this.alphabeticCode,
    this.longName,
    this.amount,
  });
}
