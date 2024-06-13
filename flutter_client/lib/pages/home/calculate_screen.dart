// Copyright (c) 2019 Razeware LLC
// See LICENSE for details.

import 'package:flutter/material.dart';
import 'package:moolax/pages/favorites/choose_favorites.dart';
import 'package:moolax/pages/home/calculate_screen_manager.dart';
import 'package:moolax/services/service_locator.dart';

class CalculateCurrencyScreen extends StatefulWidget {
  const CalculateCurrencyScreen({super.key});

  @override
  State<CalculateCurrencyScreen> createState() => _CalculateCurrencyScreenState();
}

class _CalculateCurrencyScreenState extends State<CalculateCurrencyScreen> {
  final manager = getIt<CalculateScreenManager>();
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    manager.onNetworkError = _handleNetworkError;
    manager.loadData();
    super.initState();
  }

  void _handleNetworkError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: manager,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Moola X'),
            actions: [
              if (manager.refreshState != RefreshState.hidden) _getRefreshWidget(),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () async {
                  await _goToFavorites(context);
                  manager.refreshFavorites(_controller.text);
                },
              )
            ],
          ),
          body: Column(
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
          ),
        );
      },
    );
  }

  Widget _getRefreshWidget() {
    if (manager.refreshState == RefreshState.showingButton) {
      return IconButton(
        icon: Icon(
          Icons.refresh,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () async {
          manager.forceRefresh();
        },
      );
    }
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    manager.dispose();
    super.dispose();
  }
}

Future<void> _goToFavorites(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => const ChooseFavoriteCurrencyScreen(),
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
        manager.baseCurrency.longName,
      ),
    );
  }
}

class InputBox extends StatelessWidget {
  const InputBox({
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
      child: TextField(
        style: const TextStyle(fontSize: 20),
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
                  manager.baseCurrency.flag,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          hintStyle: const TextStyle(fontSize: 14),
          hintText: 'Amount to exchange',
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: const EdgeInsets.all(20),
          suffix: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clear();
              manager.calculateExchange('');
            },
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: manager.calculateExchange,
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
            await _goToFavorites(context);
            manager.refreshFavorites(controller.text);
          },
          child: const Text('Choose exchange currency'),
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: manager.quoteCurrencies.length,
        itemBuilder: (context, index) {
          final currency = manager.quoteCurrencies[index];
          return Dismissible(
            key: UniqueKey(),
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
                      currency.flag,
                      style: const TextStyle(fontSize: 30),
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
