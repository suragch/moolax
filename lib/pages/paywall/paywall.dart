import 'package:flutter/material.dart';
import 'package:in_app_purchases_paywall_ui/in_app_purchases_paywall_ui.dart';

class MoolaxPaywall extends StatelessWidget {
  const MoolaxPaywall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SimplePaywall(
        title: 'Upgrade to Pro',
        subTitle: 'Pro accounts include:',
        continueText: 'This is continue text',
        tosData: TextAndUrl('Terms of Service', 'https://www.example.com'),
        ppData: TextAndUrl('Privacy Policy', 'https://www.example.com'),
        bulletPoints: [
          IconAndText(Icons.star, 'Access to all available currencies'),
        ],
        restoreText: 'Restore purchase',
        successTitle: 'successTitle',
        successSubTitle: 'successSubTitle',
        successWidget: Container(
          height: 100,
          color: Colors.red,
        ),
        // isSubscriptionLoading: true,
        isPurchaseInProgress: false,
        purchaseState: PurchaseState.NOT_PURCHASED,
        subscriptionListData: [
          SubscriptionData(
            durationTitle: 'Subscription',
            durationShort: 'month',
            price: '1 USD',
          ),
          SubscriptionData(
            durationTitle: 'One-time purchase',
            durationShort: 'app lifetime',
            price: '5 USD',
          ),
        ],
        // callbackInterface: CallbackInterface,
        // purchaseStateStreamInterface: PurchaseStateStreamInterface,
        activePlanList: [
          GooglePlayActivePlan(
            'productId',
            'dev.suragch.moolax',
          ),
          AppleAppStoreActivePlan()
        ],
      ),
    );
  }
}
