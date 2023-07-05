/// Copyright (c) 2019 Razeware LLC
/// See LICENSE for details.

import 'package:flutter/material.dart';
import 'package:moolax/pages/favorites/choose_favorites_viewmodel.dart';
import 'package:moolax/services/service_locator.dart';

class ChooseFavoriteCurrencyScreen extends StatefulWidget {
  @override
  _ChooseFavoriteCurrencyScreenState createState() =>
      _ChooseFavoriteCurrencyScreenState();
}

class _ChooseFavoriteCurrencyScreenState
    extends State<ChooseFavoriteCurrencyScreen> {
  ChooseFavoritesManager manager = getIt<ChooseFavoritesManager>();

  @override
  void initState() {
    manager.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Currencies'),
      ),
      body: ListView.builder(
        itemCount: manager.choices.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: SizedBox(
                width: 60,
                child: Text(
                  '${manager.choices[index].flag}',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              title: Text('${manager.choices[index].alphabeticCode}'),
              subtitle: Text('${manager.choices[index].longName}'),
              trailing: (manager.choices[index].isFavorite)
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border),
              onTap: () {
                manager.toggleFavoriteStatus(index);
              },
            ),
          );
        },
      ),
    );
  }
}
