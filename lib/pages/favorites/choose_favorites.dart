/// Copyright (c) 2019 Razeware LLC
/// See LICENSE for details.

import 'package:flutter/material.dart';
import 'package:in_app_purchases_paywall_ui/in_app_purchases_paywall_ui.dart';
import 'package:moolax/pages/favorites/choose_favorites_manager.dart';
import 'package:moolax/pages/paywall/paywall.dart';
import 'package:moolax/services/service_locator.dart';

class ChooseFavoriteCurrencyScreen extends StatefulWidget {
  @override
  State<ChooseFavoriteCurrencyScreen> createState() =>
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
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Currencies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 32,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: TextField(
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelStyle: TextStyle(fontSize: 20),
                hintStyle: TextStyle(fontSize: 20),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                contentPadding: EdgeInsets.all(20),
              ),
              keyboardType: TextInputType.name,
              onChanged: manager.search,
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        child: ProBanner(
                          isVisible: item.showBanner,
                          primaryColor: primaryColor,
                          child: ListTile(
                            leading: SizedBox(
                              width: 40,
                              child: Text(
                                item.flag,
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            title: Text(item.isoCode),
                            subtitle: Text(item.longName),
                            trailing: (item.isFavorite)
                                ? Icon(Icons.favorite, color: primaryColor)
                                : Icon(Icons.favorite_border),
                            onTap: () {
                              if (item.showBanner) {
                                _showPaywall(context);
                              } else {
                                manager.toggleFavoriteStatus(item.isoCode);
                              }
                            },
                          ),
                        ),
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

Future<void> _showPaywall(BuildContext context) async {
  // showModalBottomSheet(
  //   context: context,
  //   // isScrollControlled: true,
  //   shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //     top: Radius.circular(20),
  //   )),
  //   builder: (context) {
  //     return MoolaxPaywall();
  //   },
  // );
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MoolaxPaywall(),
    ),
  );
}

class ProBanner extends StatelessWidget {
  const ProBanner({
    super.key,
    required this.child,
    required this.primaryColor,
    required this.isVisible,
  });

  final Color primaryColor;
  final Widget child;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return child;
    return ClipRRect(
      // borderRadius: BorderRadius.circular(50),
      child: Banner(
        message: 'Pro',
        location: BannerLocation.topEnd,
        color: primaryColor,
        child: child,
      ),
    );
  }
}
