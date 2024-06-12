import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  final _inAppPurchase = InAppPurchase.instance;
  List<ProductDetails> _products = [];
  bool _isAvailable = false;

  @override
  void initState() {
    super.initState();
    initializeProducts();
  }

  Future<void> initializeProducts() async {
    bool available = await _inAppPurchase.isAvailable();
    setState(() {
      _isAvailable = available;
    });

    if (available) {
      final response = await _inAppPurchase.queryProductDetails({
        'one_time_purchase_id',
        'subscription_id',
      });
      setState(() {
        _products = response.productDetails;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      child: _isAvailable
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_products[index].title),
                        subtitle: Text(_products[index].description),
                        trailing: TextButton(
                          child: const Text('Buy'),
                          onPressed: () {
                            _inAppPurchase.buyNonConsumable(
                              purchaseParam: PurchaseParam(
                                productDetails: _products[index],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                TextButton(
                  child: const Text('Restore Purchases'),
                  onPressed: () async {
                    await _inAppPurchase.restorePurchases();
                  },
                ),
              ],
            )
          : const Center(
              child: Text('In-App Purchases are not available'),
            ),
    );
  }
}
