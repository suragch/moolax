// import 'dart:async';

// import 'package:in_app_purchase/in_app_purchase.dart';

class IapService {
//   final _inAppPurchase = InAppPurchase.instance;
//   late StreamSubscription<List<PurchaseDetails>> _subscription;
//   List<ProductDetails> _products = [];
//   bool _hasPro = false;

  // bool get hasPro => _hasPro;
  bool get hasPro => true;

  Future<void> init() async {
//     print('trying to contact IAP service');
//     final bool isAvailable = await _inAppPurchase.isAvailable();
//     print('isAvailable: $isAvailable');
//     final purchaseUpdated = _inAppPurchase.purchaseStream;
//     _subscription = purchaseUpdated.listen((purchaseDetailsList) {
//       _listenToPurchaseUpdated(purchaseDetailsList);
//     }, onDone: () {
//       print('Done listening to purchaseUpdated stream');
//       _subscription.cancel();
//     }, onError: (error) {
//       print(error);
//     });
  }

//   void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
//     for (final purchaseDetails in purchaseDetailsList) {
//       print(purchaseDetails);
//       if (purchaseDetails.status == PurchaseStatus.purchased) {
//         print('Handle successful purchase');
//         _hasPro = true;
//       } else if (purchaseDetails.status == PurchaseStatus.error) {
//         print('Handle purchase error');
//       } else if (purchaseDetails.status == PurchaseStatus.restored) {
//         print('Handle purchase restoration');
//         _hasPro = true;
//       }
//     }
//   }

  Future<void> loadProducts() async {
//     final bool isAvailable = await _inAppPurchase.isAvailable();
//     if (!isAvailable) {
//       print('Handle store not available');
//       return;
//     }

//     const productIds = {'moolax_forever'};
//     final response = await _inAppPurchase.queryProductDetails(productIds);
//     print('response: $response');
//     if (response.notFoundIDs.isNotEmpty) {
//       print('Handle product not found');
//     }
//     _products = response.productDetails;
  }

//   Future<void> purchaseProduct(String productId) async {}
//   Future<void> restorePurchases() async {}

  void dispose() {
//     _subscription.cancel();
  }
}
