/// Copyright (c) 2019 Razeware LLC
/// See LICENSE for details.

import 'package:flutter/material.dart';
import 'package:moolax/pages/home/calculate_screen.dart';
import 'package:moolax/services/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moola X',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: CalculateCurrencyScreen(),
    );
  }
}
