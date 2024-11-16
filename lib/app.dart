import 'package:flutter/material.dart';
import 'package:stripepayment/home/%20screens/home_screens.dart';

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreens(),
    );
  }
}
