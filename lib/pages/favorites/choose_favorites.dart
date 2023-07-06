/// Copyright (c) 2019 Razeware LLC
/// See LICENSE for details.

import 'package:flutter/material.dart';
import 'package:moolax/pages/favorites/choose_favorites_manager.dart';
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
    super.initState();
    manager.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Currencies'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 32),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelStyle: TextStyle(fontSize: 20),
                  hintStyle: TextStyle(fontSize: 20),
                  hintText: 'Search',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
                keyboardType: TextInputType.name,
                onChanged: manager.search,
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: manager.favoritesNotifier,
              builder: (context, list, child) {
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return Card(
                      child: ListTile(
                        leading: SizedBox(
                          width: 60,
                          child: Text(
                            '${item.flag}',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        title: Text('${item.isoCode}'),
                        subtitle: Text('${item.longName}'),
                        trailing: (item.isFavorite)
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_border),
                        onTap: () {
                          manager.toggleFavoriteStatus(item.isoCode);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
