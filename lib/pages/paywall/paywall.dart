import 'package:flutter/material.dart';
import 'package:in_app_purchases_paywall_ui/in_app_purchases_paywall_ui.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaywallScaffold(
      appBarTitle: 'Upgrade',
      child: SimplePaywall(),
    );
  }
}
