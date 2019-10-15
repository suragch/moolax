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
import 'package:moolax/business_logic/services/currency/currency_service.dart';
import 'package:moolax/business_logic/utils/IsoData.dart';
import 'package:moolax/service_locator.dart';

class CalculateScreenViewModel extends ChangeNotifier {
  final CurrencyService _currencyService = serviceLocator<CurrencyService>();

  List<Currency> _currencies = [];
  List<Rate> _rates;

  CurrencyPresentation defaultBaseCurrency = CurrencyPresentation(
      flag: '',
      alphabeticCode: '',
      longName: '',
      amount: ''
  );

  void loadData() async {
    _currencies = await _currencyService.getFavoriteCurrencies();
    _rates = await _currencyService.getAllExchangeRates();
    notifyListeners();
  }

  CurrencyPresentation get baseCurrency {
    if (_currencies.length == 0) {
      return defaultBaseCurrency;
    }
    String code = _currencies[0].isoCode;
    return CurrencyPresentation(
        flag: IsoData.flagOf(code),
        alphabeticCode: _currencies[0].isoCode,
        longName: IsoData.longNameOf(code),
        amount: ''
    );
  }

  List<CurrencyPresentation> get quoteCurrencies {
    List<CurrencyPresentation> quotes = [];
    for (int i = 1; i < _currencies.length; i++) {
      String code = _currencies[i].isoCode;
      quotes.add(CurrencyPresentation(
          flag: IsoData.flagOf(code),
          alphabeticCode: code,
          longName: IsoData.longNameOf(code),
          amount: _currencies[i].amount.toStringAsFixed(2),
      ));
    }
    return quotes;
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

  printCurrency() {
    _currencies.forEach((c) {
      print('${c.isoCode} ${c.amount}');
    });
  }

  void _updateCurrenciesFor(double baseAmount) {
    for (Currency c in _currencies) {
      for (Rate r in _rates) {
        if (c.isoCode == r.quoteCurrency) {
          c.amount = baseAmount * r.exchangeRate;
          break;
        }
      }
    }
  }
}

class CurrencyPresentation {
  final String flag;
  final String alphabeticCode;
  final String longName;
  final String amount;

  CurrencyPresentation({
    this.flag,
    this.alphabeticCode,
    this.longName,
    this.amount,
  });
}
