import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'app.dart';
import 'core/stripe_keys.dart';

void main() async{
  await _setup();
  runApp(const PaymentApp());
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}
/*

Android
  // step1: minSDk 21--app/build.gradle
  // step2:Check kotlin version--settings.gradle
  //step3:  <style name="NormalTheme" parent="Theme.MaterialComponents">-main/res/values/styles.xml(add this same value night/styles.xml)
  //step4:FlutterFragmentActivity -- mainActivity.kt
  //step5:add proguard-rules.pro--android/app
  //step6:initialized
  //step7:void main setup

*/
//await StripeService.instance.setupPaymentMethod();
//https://www.youtube.com/watch?v=Mx9TCmEioAQ