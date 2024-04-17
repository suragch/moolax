// Copyright (c) 2019 Razeware LLC
// See LICENSE for details.

class IsoData {
  /// Gives a flag for a three character ISO alphabetic [code].
  static String flagOf(String code) {
    return data[code]?['flag'] ?? '?';
  }

  /// Gives the full currency name for a three character ISO alphabetic [code].
  static String longNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  static bool isPro(String code) {
    return !freeVersionCurrencies.contains(code);
  }

  static const freeVersionCurrencies = {
    'USD',
    'EUR',
    'GBP',
    'CAD',
    'AUD',
    'JPY',
    'CNY',
    'CHF',
    'HKD',
    'INR',
    'MXN',
    'ZAR',
    'SGD',
    'NZD',
    'SEK',
    'KRW',
    'RUB',
    'BRL',
    'ARS',
    'TRY',
    'MNT'
  };

  // ISO data comes from https://en.wikipedia.org/wiki/ISO_4217
  static final Map<String, Map<String, String>> data = {
    'AED': {'name': 'United Arab Emirates dirhams', 'flag': '🇦🇪'},
    'AFN': {'name': 'Afghan afghanis', 'flag': '🇦🇫'},
    'ALL': {'name': 'Albanian leks', 'flag': '🇦🇱'},
    'AMD': {'name': 'Armenian drams', 'flag': '🇦🇲'},
    'ANG': {'name': 'Netherlands Antillean guilders', 'flag': '🇦🇼'},
    'AOA': {'name': 'Angolan kwanzas', 'flag': '🇦🇴'},
    'ARS': {'name': 'Argentine pesos', 'flag': '🇦🇷'},
    'AUD': {'name': 'Australian dollars', 'flag': '🇦🇺'},
    'AWG': {'name': 'Aruban florins', 'flag': '🇦🇼'},
    'AZN': {'name': 'Azerbaijani manats', 'flag': '🇦🇿'},
    'BAM': {'name': 'Bosnia and Herzegovina convertible marks', 'flag': '🇧🇦'},
    'BBD': {'name': 'Barbados dollars', 'flag': '🇧🇧'},
    'BDT': {'name': 'Bangladeshi takas', 'flag': '🇧🇩'},
    'BGN': {'name': 'Bulgarian levs', 'flag': '🇧🇬'},
    'BHD': {'name': 'Bahraini dinars', 'flag': '🇧🇭'},
    'BIF': {'name': 'Burundi francs', 'flag': '🇧🇮'},
    'BMD': {'name': 'Bermudian dollars', 'flag': '🇧🇲'},
    'BND': {'name': 'Brunei dollars', 'flag': '🇧🇳'},
    'BOB': {'name': 'Boliviano', 'flag': '🇧🇴'},
    'BOV': {'name': 'Bolivian mvdol', 'flag': '🇧🇴'},
    'BRL': {'name': 'Brazilian reals', 'flag': '🇧🇷'},
    'BSD': {'name': 'Bahamian dollars', 'flag': '🇧🇸'},
    'BTC': {'name': 'Bitcoin', 'flag': '₿'},
    'BTN': {'name': 'Bhutanese ngultrums', 'flag': '🇧🇹'},
    'BWP': {'name': 'Botswana pulas', 'flag': '🇧🇼'},
    'BYN': {'name': 'Belarusian rubles', 'flag': '🇧🇾'},
    'BYR': {'name': 'Belarusian rubles', 'flag': '🇧🇾'},
    'BZD': {'name': 'Belize dollars', 'flag': '🇧🇿'},
    'CAD': {'name': 'Canadian dollars', 'flag': '🇨🇦'},
    'CDF': {'name': 'Congolese francs', 'flag': '🇨🇩'},
    'CHE': {'name': 'WIR euros', 'flag': '🇨🇭'},
    'CHF': {'name': 'Swiss francs', 'flag': '🇨🇭'},
    'CHW': {'name': 'WIR francs', 'flag': '🇨🇭'},
    'CLF': {'name': 'Unidad de Fomento', 'flag': '🇨🇱'},
    'CLP': {'name': 'Chilean pesos', 'flag': '🇨🇱'},
    'CNY': {'name': 'Chinese yuan (renminbi)', 'flag': '🇨🇳'},
    'COP': {'name': 'Colombian pesos', 'flag': '🇨🇴'},
    'COU': {'name': 'Unidad de Valor Real (UVR)', 'flag': '🇨🇴'},
    'CRC': {'name': 'Costa Rican colons', 'flag': '🇨🇷'},
    'CUC': {'name': 'Cuban convertible pesos', 'flag': '🇨🇺'},
    'CUP': {'name': 'Cuban pesos', 'flag': '🇨🇺'},
    'CVE': {'name': 'Cape Verdean escudos', 'flag': '🇨🇻'},
    'CZK': {'name': 'Czech korunas', 'flag': '🇨🇿'},
    'DJF': {'name': 'Djiboutian francs', 'flag': '🇩🇯'},
    'DKK': {'name': 'Danish kroner', 'flag': '🇩🇰'},
    'DOP': {'name': 'Dominican pesos', 'flag': '🇩🇴'},
    'DZD': {'name': 'Algerian dinars', 'flag': '🇩🇿'},
    'EGP': {'name': 'Egyptian pounds', 'flag': '🇪🇬'},
    'ERN': {'name': 'Eritrean nakfas', 'flag': '🇪🇷'},
    'ETB': {'name': 'Ethiopian birrs', 'flag': '🇪🇹'},
    'EUR': {'name': 'Euros', 'flag': '🇪🇺'},
    'FJD': {'name': 'Fiji dollars', 'flag': '🇫🇯'},
    'FKP': {'name': 'Falkland Islands pounds', 'flag': '🇫🇰'},
    'GBP': {'name': 'Pound sterling', 'flag': '🇬🇧'},
    'GEL': {'name': 'Georgian lari', 'flag': '🇬🇪'},
    'GGP': {'name': 'Guernsey pounds', 'flag': '🇬🇧'},
    'GHS': {'name': 'Ghana cedis', 'flag': '🇬🇭'},
    'GIP': {'name': 'Gibraltar pounds', 'flag': '🇬🇮'},
    'GMD': {'name': 'Gambian dalasi', 'flag': '🇬🇲'},
    'GNF': {'name': 'Guinean francs', 'flag': '🇬🇳'},
    'GTQ': {'name': 'Guatemalan quetzals', 'flag': '🇬🇹'},
    'GYD': {'name': 'Guyanese dollars', 'flag': '🇬🇾'},
    'HKD': {'name': 'Hong Kong dollars', 'flag': '🇭🇰'},
    'HNL': {'name': 'Honduran lempira', 'flag': '🇭🇳'},
    'HRK': {'name': 'Croatian kuna', 'flag': '🇭🇷'},
    'HTG': {'name': 'Haitian gourdes', 'flag': '🇭🇹'},
    'HUF': {'name': 'Hungarian forints', 'flag': '🇭🇺'},
    'IDR': {'name': 'Indonesian rupiahs', 'flag': '🇮🇩'},
    'ILS': {'name': 'Israeli new shekels', 'flag': '🇮🇱'},
    'IMP': {'name': 'Manx pound (Isle of Man pound)', 'flag': '🇬🇧'},
    'INR': {'name': 'Indian rupees', 'flag': '🇮🇳'},
    'IQD': {'name': 'Iraqi dinars', 'flag': '🇮🇶'},
    'IRR': {'name': 'Iranian rials', 'flag': '🇮🇷'},
    'ISK': {'name': 'Icelandic krónur', 'flag': '🇮🇸'},
    'JEP': {'name': 'Jersey pounds', 'flag': '🇬🇧'},
    'JMD': {'name': 'Jamaican dollars', 'flag': '🇯🇲'},
    'JOD': {'name': 'Jordanian dinars', 'flag': '🇯🇴'},
    'JPY': {'name': 'Japanese yen', 'flag': '🇯🇵'},
    'KES': {'name': 'Kenyan shillings', 'flag': '🇰🇪'},
    'KGS': {'name': 'Kyrgyzstani soms', 'flag': '🇰🇬'},
    'KHR': {'name': 'Cambodian riels', 'flag': '🇰🇭'},
    'KMF': {'name': 'Comoro francs', 'flag': '🇰🇲'},
    'KPW': {'name': 'North Korean won', 'flag': '🇰🇵'},
    'KRW': {'name': 'South Korean won', 'flag': '🇰🇷'},
    'KWD': {'name': 'Kuwaiti dinars', 'flag': '🇰🇼'},
    'KYD': {'name': 'Cayman Islands dollars', 'flag': '🇰🇾'},
    'KZT': {'name': 'Kazakhstani tenge', 'flag': '🇰🇿'},
    'LAK': {'name': 'Lao kip', 'flag': '🇱🇦'},
    'LBP': {'name': 'Lebanese pounds', 'flag': '🇱🇧'},
    'LKR': {'name': 'Sri Lanka rupees', 'flag': '🇱🇰'},
    'LRD': {'name': 'Liberian dollars', 'flag': '🇱🇷'},
    'LSL': {'name': 'Lesotho loti', 'flag': '🇱🇸'},
    'LTL': {'name': 'Lithuanian litas', 'flag': '🇱🇹'},
    'LVL': {'name': 'Latvian lats', 'flag': '🇱🇻'},
    'LYD': {'name': 'Libyan dinars', 'flag': '🇱🇾'},
    'MAD': {'name': 'Moroccan dirhams', 'flag': '🇲🇦'},
    'MDL': {'name': 'Moldovan leu', 'flag': '🇲🇩'},
    'MGA': {'name': 'Malagasy ariary', 'flag': '🇲🇬'},
    'MKD': {'name': 'Macedonian denar', 'flag': '🇲🇰'},
    'MMK': {'name': 'Myanmar kyat', 'flag': '🇲🇲'},
    'MNT': {'name': 'Mongolian tögrög', 'flag': '🇲🇳'},
    'MOP': {'name': 'Macanese pataca', 'flag': '🇲🇴'},
    'MRO': {'name': 'Mauritanian ouguiya', 'flag': '🇲🇷'},
    'MRU': {'name': 'Mauritanian ouguiya', 'flag': '🇲🇷'},
    'MUR': {'name': 'Mauritian rupees', 'flag': '🇲🇺'},
    'MVR': {'name': 'Maldivian rufiyaa', 'flag': '🇲🇻'},
    'MWK': {'name': 'Malawian kwacha', 'flag': '🇲🇼'},
    'MXN': {'name': 'Mexican pesos', 'flag': '🇲🇽'},
    'MXV': {'name': 'Mexican Unidad de Inversion (UDI)', 'flag': '🇲🇽'},
    'MYR': {'name': 'Malaysian ringgit', 'flag': '🇲🇾'},
    'MZN': {'name': 'Mozambican metical', 'flag': '🇲🇿'},
    'NAD': {'name': 'Namibian dollars', 'flag': '🇳🇦'},
    'NGN': {'name': 'Nigerian naira', 'flag': '🇳🇬'},
    'NIO': {'name': 'Nicaraguan córdoba', 'flag': '🇳🇮'},
    'NOK': {'name': 'Norwegian kroner', 'flag': '🇳🇴'},
    'NPR': {'name': 'Nepalese rupees', 'flag': '🇳🇵'},
    'NZD': {'name': 'New Zealand dollars', 'flag': '🇳🇿'},
    'OMR': {'name': 'Omani rials', 'flag': '🇴🇲'},
    'PAB': {'name': 'Panamanian balboa', 'flag': '🇵🇦'},
    'PEN': {'name': 'Peruvian sol', 'flag': '🇵🇪'},
    'PGK': {'name': 'Papua New Guinean kina', 'flag': '🇵🇬'},
    'PHP': {'name': 'Philippine pesos', 'flag': '🇵🇭'},
    'PKR': {'name': 'Pakistan rupees', 'flag': '🇵🇰'},
    'PLN': {'name': 'Polish złoty', 'flag': '🇵🇱'},
    'PYG': {'name': 'Paraguayan guaraní', 'flag': '🇵🇾'},
    'QAR': {'name': 'Qatari rials', 'flag': '🇶🇦'},
    'RON': {'name': 'Romanian leu', 'flag': '🇷🇴'},
    'RSD': {'name': 'Serbian dinars', 'flag': '🇷🇸'},
    'RUB': {'name': 'Russian rubles', 'flag': '🇷🇺'},
    'RWF': {'name': 'Rwanda francs', 'flag': '🇷🇼'},
    'SAR': {'name': 'Saudi riyal', 'flag': '🇸🇦'},
    'SBD': {'name': 'Solomon Islands dollars', 'flag': '🇸🇧'},
    'SCR': {'name': 'Seychelles rupees', 'flag': '🇸🇨'},
    'SDG': {'name': 'Sudanese pounds', 'flag': '🇸🇩'},
    'SEK': {'name': 'Swedish kronor', 'flag': '🇸🇪'},
    'SGD': {'name': 'Singapore dollars', 'flag': '🇸🇬'},
    'SHP': {'name': 'Saint Helena pounds', 'flag': '🇸🇭'},
    'SLE': {'name': 'Sierra Leonean leone (new leone)', 'flag': '🇸🇱'},
    'SLL': {'name': 'Sierra Leonean leone (old leone)', 'flag': '🇸🇱'},
    'SOS': {'name': 'Somali shillings', 'flag': '🇸🇴'},
    'SRD': {'name': 'Surinamese dollars', 'flag': '🇸🇷'},
    'SSP': {'name': 'South Sudanese pounds', 'flag': '🇸🇸'},
    'STD': {'name': 'São Tomé and Príncipe dobra', 'flag': '🇸🇹'},
    'STN': {'name': 'São Tomé and Príncipe dobra', 'flag': '🇸🇹'},
    'SVC': {'name': 'Salvadoran colón', 'flag': '🇸🇻'},
    'SYP': {'name': 'Syrian pounds', 'flag': '🇸🇾'},
    'SZL': {'name': 'Swazi lilangeni', 'flag': '🇸🇿'},
    'THB': {'name': 'Thai baht', 'flag': '🇹🇭'},
    'TJS': {'name': 'Tajikistani somoni', 'flag': '🇹🇯'},
    'TMT': {'name': 'Turkmenistan manats', 'flag': '🇹🇲'},
    'TND': {'name': 'Tunisian dinars', 'flag': '🇹🇳'},
    'TOP': {'name': "Tongan pa'anga", 'flag': '🇹🇴'},
    'TRY': {'name': 'Turkish liras', 'flag': '🇹🇷'},
    'TTD': {'name': 'Trinidad and Tobago dollars', 'flag': '🇹🇹'},
    'TWD': {'name': 'New Taiwan dollars', 'flag': '🇹🇼'},
    'TZS': {'name': 'Tanzanian shillings', 'flag': '🇹🇿'},
    'UAH': {'name': 'Ukrainian hryvnia', 'flag': '🇺🇦'},
    'UGX': {'name': 'Uganda shillings', 'flag': '🇺🇬'},
    'USD': {'name': 'United States dollars', 'flag': '🇺🇸'},
    'USN': {
      'name': 'United States dollar (next day) (funds code)',
      'flag': '🇺🇸'
    },
    'UYI': {
      'name': 'Uruguay Peso en Unidades Indexadas (URUIURUI) (funds code)',
      'flag': '🇺🇾'
    },
    'UYU': {'name': 'Uruguayan pesos', 'flag': '🇺🇾'},
    'UYW': {'name': 'Unidad previsional', 'flag': '🇺🇾'},
    'UZS': {'name': 'Uzbekistan sum', 'flag': '🇺🇿'},
    'VED': {'name': 'Venezuelan digital bolívars', 'flag': '🇻🇪'},
    'VEF': {'name': 'Venezuelan bolívar fuerte', 'flag': '🇻🇪'},
    'VES': {'name': 'Venezuelan sovereign bolívars', 'flag': '🇻🇪'},
    'VND': {'name': 'Vietnamese dong', 'flag': '🇻🇳'},
    'VUV': {'name': 'Vanuatu vatu', 'flag': '🇻🇺'},
    'WST': {'name': 'Samoan tala', 'flag': '🇼🇸'},
    'XAF': {'name': 'Central African CFA francs', 'flag': '🌍'},
    'XAG': {'name': 'Silver (one troy ounce)', 'flag': '🥈'},
    'XAU': {'name': 'Gold (one troy ounce)', 'flag': '🥇'},
    'XBA': {
      'name': 'European Composite Unit (EURCO) (bond market unit)',
      'flag': '',
    },
    'XBB': {
      'name': 'European Monetary Unit (E.M.U.-6) (bond market unit)',
      'flag': ''
    },
    'XBC': {
      'name': 'European Unit of Account 9 (E.U.A.-9) (bond market unit)',
      'flag': ''
    },
    'XBD': {
      'name': 'European Unit of Account 17 (E.U.A.-17) (bond market unit)',
      'flag': ''
    },
    'XCD': {'name': 'East Caribbean dollars', 'flag': r'🏝️'},
    'XDR': {'name': 'Special drawing rights (IMF)', 'flag': '🇺🇳'},
    'XOF': {'name': 'West African CFA francs', 'flag': '🌍'},
    'XPD': {'name': 'Palladium (one troy ounce)', 'flag': ''},
    'XPF': {'name': 'CFP francs', 'flag': '🏝️'},
    'XPT': {'name': 'Platinum (one troy ounce)', 'flag': ''},
    'XSU': {
      'name': 'Unified System for Regional Compensation (SUCRE)',
      'flag': ''
    },
    'XTS': {'name': 'Code reserved for testing', 'flag': ''},
    'XUA': {'name': 'ADB Unit of Account', 'flag': ''},
    'XXX': {'name': 'No currency', 'flag': ''},
    'YER': {'name': 'Yemeni rials', 'flag': '🇾🇪'},
    'ZAR': {'name': 'South African rand', 'flag': '🇿🇦'},
    'ZMK': {'name': 'Zambian kwacha', 'flag': '🇿🇲'},
    'ZMW': {'name': 'Zambian kwacha', 'flag': '🇿🇲'},
    'ZWL': {'name': 'Zimbabwe dollars', 'flag': '🇿🇼'},
  };
}
