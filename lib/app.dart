import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:stripepayment/home/%20screens/home_screens.dart';

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      builder: EasyLoading.init(),
      home: const HomeScreens(),
    );
  }
}
