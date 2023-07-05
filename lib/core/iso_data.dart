/// Copyright (c) 2019 Razeware LLC
/// See LICENSE for details.

class IsoData {
  /// Gives a flag for a three character ISO alphabetic [code].
  static String flagOf(String code) {
    return data[code]?['flag'] ?? '?';
  }

  /// Gives the full currency name for a three character ISO alphabetic [code].
  static String longNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  // ISO data comes from https://en.wikipedia.org/wiki/ISO_4217
  static final Map<String, Map<String, String>> data = {
    'AED': {'name': 'United Arab Emirates dirham', 'flag': '🇦🇪'},
    'AFN': {'name': 'Afghan afghani', 'flag': '🇦🇫'},
    'ALL': {'name': 'Albanian lek', 'flag': '🇦🇱'},
    'AMD': {'name': 'Armenian dram', 'flag': '🇦🇲'},
    'ANG': {'name': 'Netherlands Antillean guilder', 'flag': '🇦🇼'},
    'AOA': {'name': 'Angolan kwanza', 'flag': '🇦🇴'},
    'ARS': {'name': 'Argentine peso', 'flag': '🇦🇷'},
    'AUD': {'name': 'Australian dollar', 'flag': '🇦🇺'},
    'AWG': {'name': 'Aruban florin', 'flag': '🇦🇼'},
    'AZN': {'name': 'Azerbaijani manat', 'flag': '🇦🇿'},
    'BAM': {'name': 'Bosnia and Herzegovina convertible mark', 'flag': '🇧🇦'},
    'BBD': {'name': 'Barbados dollar', 'flag': '🇧🇧'},
    'BDT': {'name': 'Bangladeshi taka', 'flag': '🇧🇩'},
    'BGN': {'name': 'Bulgarian lev', 'flag': '🇧🇬'},
    'BHD': {'name': 'Bahraini dinar', 'flag': '🇧🇭'},
    'BIF': {'name': 'Burundi franc', 'flag': '🇧🇮'},
    'BMD': {'name': 'Bermudian dollar', 'flag': '🇧🇲'},
    'BND': {'name': 'Brunei dollar', 'flag': '🇧🇳'},
    'BOB': {'name': 'Boliviano', 'flag': '🇧🇴'},
    'BOV': {'name': 'Bolivian mvdol', 'flag': '🇧🇴'},
    'BRL': {'name': 'Brazilian real', 'flag': '🇧🇷'},
    'BSD': {'name': 'Bahamian dollar', 'flag': '🇧🇸'},
    'BTC': {'name': 'Bitcoin', 'flag': '₿'},
    'BTN': {'name': 'Bhutanese ngultrum', 'flag': '🇧🇹'},
    'BWP': {'name': 'Botswana pula', 'flag': '🇧🇼'},
    'BYN': {'name': 'Belarusian ruble', 'flag': '🇧🇾'},
    'BYR': {'name': 'Belarusian ruble', 'flag': '🇧🇾'},
    'BZD': {'name': 'Belize dollar', 'flag': '🇧🇿'},
    'CAD': {'name': 'Canadian dollar', 'flag': '🇨🇦'},
    'CDF': {'name': 'Congolese franc', 'flag': '🇨🇩'},
    'CHE': {'name': 'WIR Euro', 'flag': '🇨🇭'},
    'CHF': {'name': 'Swiss Franc', 'flag': '🇨🇭'},
    'CHW': {'name': 'WIR Franc', 'flag': '🇨🇭'},
    'CLF': {'name': 'Unidad de Fomento', 'flag': '🇨🇱'},
    'CLP': {'name': 'Chilean peso', 'flag': '🇨🇱'},
    'CNY': {'name': 'Chinese yuan (renminbi)', 'flag': '🇨🇳'},
    'COP': {'name': 'Colombian peso', 'flag': '🇨🇴'},
    'COU': {'name': 'Unidad de Valor Real (UVR)', 'flag': '🇨🇴'},
    'CRC': {'name': 'Costa Rican colon', 'flag': '🇨🇷'},
    'CUC': {'name': 'Cuban convertible peso', 'flag': '🇨🇺'},
    'CUP': {'name': 'Cuban peso', 'flag': '🇨🇺'},
    'CVE': {'name': 'Cape Verdean escudo', 'flag': '🇨🇻'},
    'CZK': {'name': 'Czech koruna', 'flag': '🇨🇿'},
    'DJF': {'name': 'Djiboutian franc', 'flag': '🇩🇯'},
    'DKK': {'name': 'Danish krone', 'flag': '🇩🇰'},
    'DOP': {'name': 'Dominican peso', 'flag': '🇩🇴'},
    'DZD': {'name': 'Algerian dinar', 'flag': '🇩🇿'},
    'EGP': {'name': 'Egyptian pound', 'flag': '🇪🇬'},
    'ERN': {'name': 'Eritrean nakfa', 'flag': '🇪🇷'},
    'ETB': {'name': 'Ethiopian birr', 'flag': '🇪🇹'},
    'EUR': {'name': 'Euro', 'flag': '🇪🇺'},
    'FJD': {'name': 'Fiji dollar', 'flag': '🇫🇯'},
    'FKP': {'name': 'Falkland Islands pound', 'flag': '🇫🇰'},
    'GBP': {'name': 'Pound sterling', 'flag': '🇬🇧'},
    'GEL': {'name': 'Georgian lari', 'flag': '🇬🇪'},
    'GGP': {'name': 'Guernsey pound', 'flag': '🇬🇧'},
    'GHS': {'name': 'Ghana cedi', 'flag': '🇬🇭'},
    'GIP': {'name': 'Gibraltar pound', 'flag': '🇬🇮'},
    'GMD': {'name': 'Gambian dalasi', 'flag': '🇬🇲'},
    'GNF': {'name': 'Guinean franc', 'flag': '🇬🇳'},
    'GTQ': {'name': 'Guatemalan quetzal', 'flag': '🇬🇹'},
    'GYD': {'name': 'Guyanese dollar', 'flag': '🇬🇾'},
    'HKD': {'name': 'Hong Kong dollar', 'flag': '🇭🇰'},
    'HNL': {'name': 'Honduran lempira', 'flag': '🇭🇳'},
    'HRK': {'name': 'Croatian kuna', 'flag': '🇭🇷'},
    'HTG': {'name': 'Haitian gourde', 'flag': '🇭🇹'},
    'HUF': {'name': 'Hungarian forint', 'flag': '🇭🇺'},
    'IDR': {'name': 'Indonesian rupiah', 'flag': '🇮🇩'},
    'ILS': {'name': 'Israeli new shekel', 'flag': '🇮🇱'},
    'IMP': {'name': 'Manx pound (Isle of Man pound)', 'flag': '🇬🇧'},
    'INR': {'name': 'Indian rupee', 'flag': '🇮🇳'},
    'IQD': {'name': 'Iraqi dinar', 'flag': '🇮🇶'},
    'IRR': {'name': 'Iranian rial', 'flag': '🇮🇷'},
    'ISK': {'name': 'Icelandic króna', 'flag': '🇮🇸'},
    'JEP': {'name': 'Jersey pound', 'flag': '🇬🇧'},
    'JMD': {'name': 'Jamaican dollar', 'flag': '🇯🇲'},
    'JOD': {'name': 'Jordanian dinar', 'flag': '🇯🇴'},
    'JPY': {'name': 'Japanese yen', 'flag': '🇯🇵'},
    'KES': {'name': 'Kenyan shilling', 'flag': '🇰🇪'},
    'KGS': {'name': 'Kyrgyzstani som', 'flag': '🇰🇬'},
    'KHR': {'name': 'Cambodian riel', 'flag': '🇰🇭'},
    'KMF': {'name': 'Comoro franc', 'flag': '🇰🇲'},
    'KPW': {'name': 'North Korean won', 'flag': '🇰🇵'},
    'KRW': {'name': 'South Korean won', 'flag': '🇰🇷'},
    'KWD': {'name': 'Kuwaiti dinar', 'flag': '🇰🇼'},
    'KYD': {'name': 'Cayman Islands dollar', 'flag': '🇰🇾'},
    'KZT': {'name': 'Kazakhstani tenge', 'flag': '🇰🇿'},
    'LAK': {'name': 'Lao kip', 'flag': '🇱🇦'},
    'LBP': {'name': 'Lebanese pound', 'flag': '🇱🇧'},
    'LKR': {'name': 'Sri Lanka rupee', 'flag': '🇱🇰'},
    'LRD': {'name': 'Liberian dollar', 'flag': '🇱🇷'},
    'LSL': {'name': 'Lesotho loti', 'flag': '🇱🇸'},
    'LTL': {'name': 'Lithuanian litas', 'flag': '🇱🇹'},
    'LVL': {'name': 'Latvian lats', 'flag': '🇱🇻'},
    'LYD': {'name': 'Libyan dinar', 'flag': '🇱🇾'},
    'MAD': {'name': 'Moroccan dirham', 'flag': '🇲🇦'},
    'MDL': {'name': 'Moldovan leu', 'flag': '🇲🇩'},
    'MGA': {'name': 'Malagasy ariary', 'flag': '🇲🇬'},
    'MKD': {'name': 'Macedonian denar', 'flag': '🇲🇰'},
    'MMK': {'name': 'Myanmar kyat', 'flag': '🇲🇲'},
    'MNT': {'name': 'Mongolian tögrög', 'flag': '🇲🇳'},
    'MOP': {'name': 'Macanese pataca', 'flag': '🇲🇴'},
    'MRO': {'name': 'Mauritanian ouguiya', 'flag': '🇲🇷'},
    'MRU': {'name': 'Mauritanian ouguiya', 'flag': '🇲🇷'},
    'MUR': {'name': 'Mauritian rupee', 'flag': '🇲🇺'},
    'MVR': {'name': 'Maldivian rufiyaa', 'flag': '🇲🇻'},
    'MWK': {'name': 'Malawian kwacha', 'flag': '🇲🇼'},
    'MXN': {'name': 'Mexican peso', 'flag': '🇲🇽'},
    'MXV': {'name': 'Mexican Unidad de Inversion (UDI)', 'flag': '🇲🇽'},
    'MYR': {'name': 'Malaysian ringgit', 'flag': '🇲🇾'},
    'MZN': {'name': 'Mozambican metical', 'flag': '🇲🇿'},
    'NAD': {'name': 'Namibian dollar', 'flag': '🇳🇦'},
    'NGN': {'name': 'Nigerian naira', 'flag': '🇳🇬'},
    'NIO': {'name': 'Nicaraguan córdoba', 'flag': '🇳🇮'},
    'NOK': {'name': 'Norwegian krone', 'flag': '🇳🇴'},
    'NPR': {'name': 'Nepalese rupee', 'flag': '🇳🇵'},
    'NZD': {'name': 'New Zealand dollar', 'flag': '🇳🇿'},
    'OMR': {'name': 'Omani rial', 'flag': '🇴🇲'},
    'PAB': {'name': 'Panamanian balboa', 'flag': '🇵🇦'},
    'PEN': {'name': 'Peruvian sol', 'flag': '🇵🇪'},
    'PGK': {'name': 'Papua New Guinean kina', 'flag': '🇵🇬'},
    'PHP': {'name': 'Philippine peso', 'flag': '🇵🇭'},
    'PKR': {'name': 'Pakistan rupee', 'flag': '🇵🇰'},
    'PLN': {'name': 'Polish złoty', 'flag': '🇵🇱'},
    'PYG': {'name': 'Paraguayan guaraní', 'flag': '🇵🇾'},
    'QAR': {'name': 'Qatari rial', 'flag': '🇶🇦'},
    'RON': {'name': 'Romanian leu', 'flag': '🇷🇴'},
    'RSD': {'name': 'Serbian dinar', 'flag': '🇷🇸'},
    'RUB': {'name': 'Russian ruble', 'flag': '🇷🇺'},
    'RWF': {'name': 'Rwanda franc', 'flag': '🇷🇼'},
    'SAR': {'name': 'Saudi riyal', 'flag': '🇸🇦'},
    'SBD': {'name': 'Solomon Islands dollar', 'flag': '🇸🇧'},
    'SCR': {'name': 'Seychelles rupee', 'flag': '🇸🇨'},
    'SDG': {'name': 'Sudanese pound', 'flag': '🇸🇩'},
    'SEK': {'name': 'Swedish krona', 'flag': '🇸🇪'},
    'SGD': {'name': 'Singapore dollar', 'flag': '🇸🇬'},
    'SHP': {'name': 'Saint Helena pound', 'flag': '🇸🇭'},
    'SLE': {'name': 'Sierra Leonean leone (new leone)', 'flag': '🇸🇱'},
    'SLL': {'name': 'Sierra Leonean leone (old leone)', 'flag': '🇸🇱'},
    'SOS': {'name': 'Somali shilling', 'flag': '🇸🇴'},
    'SRD': {'name': 'Surinamese dollar', 'flag': '🇸🇷'},
    'SSP': {'name': 'South Sudanese pound', 'flag': '🇸🇸'},
    'STD': {'name': 'São Tomé and Príncipe dobra', 'flag': '🇸🇹'},
    'STN': {'name': 'São Tomé and Príncipe dobra', 'flag': '🇸🇹'},
    'SVC': {'name': 'Salvadoran colón', 'flag': '🇸🇻'},
    'SYP': {'name': 'Syrian pound', 'flag': '🇸🇾'},
    'SZL': {'name': 'Swazi lilangeni', 'flag': '🇸🇿'},
    'THB': {'name': 'Thai baht', 'flag': '🇹🇭'},
    'TJS': {'name': 'Tajikistani somoni', 'flag': '🇹🇯'},
    'TMT': {'name': 'Turkmenistan manat', 'flag': '🇹🇲'},
    'TND': {'name': 'Tunisian dinar', 'flag': '🇹🇳'},
    'TOP': {'name': "Tongan pa'anga", 'flag': '🇹🇴'},
    'TRY': {'name': 'Turkish lira', 'flag': '🇹🇷'},
    'TTD': {'name': 'Trinidad and Tobago dollar', 'flag': '🇹🇹'},
    'TWD': {'name': 'New Taiwan dollar', 'flag': '🇹🇼'},
    'TZS': {'name': 'Tanzanian shilling', 'flag': '🇹🇿'},
    'UAH': {'name': 'Ukrainian hryvnia', 'flag': '🇺🇦'},
    'UGX': {'name': 'Uganda shilling', 'flag': '🇺🇬'},
    'USD': {'name': 'United States dollar', 'flag': '🇺🇸'},
    'USN': {
      'name': 'United States dollar (next day) (funds code)',
      'flag': '🇺🇸'
    },
    'UYI': {
      'name': 'Uruguay Peso en Unidades Indexadas (URUIURUI) (funds code)',
      'flag': '🇺🇾'
    },
    'UYU': {'name': 'Uruguayan peso', 'flag': '🇺🇾'},
    'UYW': {'name': 'Unidad previsional', 'flag': '🇺🇾'},
    'UZS': {'name': 'Uzbekistan sum', 'flag': '🇺🇿'},
    'VED': {'name': 'Venezuelan digital bolívar', 'flag': '🇻🇪'},
    'VEF': {'name': 'Venezuelan bolívar fuerte', 'flag': '🇻🇪'},
    'VES': {'name': 'Venezuelan sovereign bolívar', 'flag': '🇻🇪'},
    'VND': {'name': 'Vietnamese dong', 'flag': '🇻🇳'},
    'VUV': {'name': 'Vanuatu vatu', 'flag': '🇻🇺'},
    'WST': {'name': 'Samoan tala', 'flag': '🇼🇸'},
    'XAF': {'name': 'CFA Franc BEAC', 'flag': ''},
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
    'XCD': {'name': 'East Caribbean Dollar', 'flag': ''},
    'XDR': {
      'name': 'Special drawing rights (International Monetary Fund)',
      'flag': ''
    },
    'XOF': {'name': 'CFA franc BCEAO', 'flag': ''},
    'XPD': {'name': 'Palladium (one troy ounce)', 'flag': ''},
    'XPF': {'name': 'CFP franc', 'flag': ''},
    'XPT': {'name': 'Platinum (one troy ounce)', 'flag': ''},
    'XSU': {
      'name': 'Unified System for Regional Compensation (SUCRE)',
      'flag': ''
    },
    'XTS': {'name': 'Code reserved for testing', 'flag': ''},
    'XUA': {'name': 'ADB Unit of Account', 'flag': ''},
    'XXX': {'name': 'No currency', 'flag': ''},
    'YER': {'name': 'Yemeni rial', 'flag': '🇾🇪'},
    'ZAR': {'name': 'South African rand', 'flag': '🇿🇦'},
    'ZMK': {'name': 'Zambian kwacha', 'flag': '🇿🇲'},
    'ZMW': {'name': 'Zambian kwacha', 'flag': '🇿🇲'},
    'ZWL': {'name': 'Zimbabwe dollar', 'flag': '🇿🇼'},
  };
}
