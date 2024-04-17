// Copyright (c) 2019 Razeware LLC
// See LICENSE for details.

import 'package:flutter/material.dart';
import 'package:moolax/pages/home/calculate_screen.dart';
import 'package:moolax/services/currency_service.dart';
import 'package:moolax/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  final currencyService = getIt<CurrencyService>();
  await currencyService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moola X',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const CalculateCurrencyScreen(),
    );
  }
}
