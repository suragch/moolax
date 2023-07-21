/// Copyright (c) 2019 Razeware LLC
/// See LICENSE for details.

import 'package:flutter/material.dart';
import 'package:moolax/pages/favorites/choose_favorites.dart';
import 'package:moolax/pages/home/calculate_screen_manager.dart';
import 'package:moolax/services/service_locator.dart';

class CalculateCurrencyScreen extends StatefulWidget {
  @override
  _CalculateCurrencyScreenState createState() =>
      _CalculateCurrencyScreenState();
}

class _CalculateCurrencyScreenState extends State<CalculateCurrencyScreen> {
  final manager = getIt<CalculateScreenManager>();
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    manager.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moola X'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () async {
              await _goToFavorites(context, manager);
              manager.refreshFavorites(_controller.text);
            },
          )
        ],
      ),
      body: ListenableBuilder(
        listenable: manager,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Title(manager: manager),
              InputBox(
                manager: manager,
                controller: _controller,
                focusNode: _focusNode,
              ),
              FavoritesList(
                manager: manager,
                controller: _controller,
                focusNode: _focusNode,
              ),
            ],
          );
        },
      ),
    );
  }
}

Future<void> _goToFavorites(
  BuildContext context,
  CalculateScreenManager manager,
) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChooseFavoriteCurrencyScreen(),
    ),
  );
}

class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.manager,
  });

  final CalculateScreenManager manager;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, top: 32, right: 32, bottom: 5),
      child: Text(
        '${manager.baseCurrency.longName}',
      ),
    );
  }
}

class InputBox extends StatelessWidget {
  InputBox({
    super.key,
    required this.controller,
    required this.manager,
    required this.focusNode,
  });

  final TextEditingController controller;
  final CalculateScreenManager manager;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 32),
      child: Container(
        child: TextField(
          style: TextStyle(fontSize: 20),
          controller: controller,
          autofocus: true,
          focusNode: focusNode,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                width: 50,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${manager.baseCurrency.flag}',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            hintStyle: TextStyle(fontSize: 14),
            hintText: 'Amount to exchange',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            contentPadding: EdgeInsets.all(20),
            suffix: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                controller.clear();
                manager.calculateExchange('');
              },
            ),
          ),
          keyboardType: TextInputType.number,
          onChanged: manager.calculateExchange,
        ),
      ),
    );
  }
}

class FavoritesList extends StatelessWidget {
  const FavoritesList({
    super.key,
    required this.manager,
    required this.controller,
    required this.focusNode,
  });

  final CalculateScreenManager manager;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    if (manager.quoteCurrencies.isEmpty) {
      return Center(
        child: ElevatedButton(
          onPressed: () async {
            await _goToFavorites(context, manager);
            manager.refreshFavorites(controller.text);
          },
          child: Text('Choose exchange currency'),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: manager.quoteCurrencies.length,
        itemBuilder: (context, index) {
          final currency = manager.quoteCurrencies[index];
          return Dismissible(
            key: Key(currency.isoCode),
            onDismissed: (direction) {
              manager.unfavorite(currency.isoCode);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: ListTile(
                  leading: SizedBox(
                    width: 40,
                    child: Text(
                      '${currency.flag}',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  title: Text(currency.amount),
                  subtitle: Text(currency.longName),
                  onTap: () {
                    manager.setNewBaseCurrency(index);
                    controller.clear();
                    focusNode.requestFocus();
                  },
                  onLongPress: () {
                    // delete
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
