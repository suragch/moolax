// Copyright (c) 2019 Razeware LLC
// See LICENSE for details.

class Currency {
  // Use an ISO alphabetic code.
  final String isoCode;

  Currency(this.isoCode) {
    if (isoCode.length != 3) {
      throw ArgumentError('The ISO code must have a length of 3.');
    }
  }
}
