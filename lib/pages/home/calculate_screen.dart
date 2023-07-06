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
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChooseFavoriteCurrencyScreen(),
                ),
              );
              manager.refreshFavorites();
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
              InputBox(manager: manager, controller: _controller),
              FavoritesList(manager: manager, controller: _controller),
            ],
          );
        },
      ),
    );
  }
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
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    required TextEditingController controller,
    required this.manager,
  }) : _controller = controller;

  final TextEditingController _controller;
  final CalculateScreenManager manager;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: TextField(
          style: TextStyle(fontSize: 20),
          controller: _controller,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                width: 60,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${manager.baseCurrency.flag}',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            labelStyle: TextStyle(fontSize: 20),
            hintStyle: TextStyle(fontSize: 20),
            hintText: 'Amount to exchange',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(20),
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
    required TextEditingController controller,
  }) : _controller = controller;

  final CalculateScreenManager manager;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: manager.quoteCurrencies.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: SizedBox(
                width: 60,
                child: Text(
                  '${manager.quoteCurrencies[index].flag}',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              title: Text(manager.quoteCurrencies[index].amount),
              subtitle: Text(manager.quoteCurrencies[index].longName),
              onTap: () {
                manager.setNewBaseCurrency(index);
                _controller.clear();
              },
            ),
          );
        },
      ),
    );
  }
}
