/// Copyright (c) 2019 Razeware LLC
/// See LICENSE for details.

class Rate {
  /// Use an ISO alphabetic code.
  final String baseCurrency;

  /// Use an ISO alphabetic code.
  final String quoteCurrency;

  final double exchangeRate;

  Rate({
    required this.baseCurrency,
    required this.quoteCurrency,
    required this.exchangeRate,
  }) {
    if (baseCurrency.length != 3 || quoteCurrency.length != 3)
      throw ArgumentError('The ISO code must have a length of 3.');
  }

  factory Rate.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'baseCurrency': String baseCurrency,
          'quoteCurrency': String quoteCurrency,
          'exchangeRate': double exchangeRate,
        }) {
      return Rate(
        baseCurrency: baseCurrency,
        quoteCurrency: quoteCurrency,
        exchangeRate: exchangeRate,
      );
    } else {
      throw FormatException('Invalid JSON');
    }
  }
}
