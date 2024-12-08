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

  //step3:  <style name="NormalTheme" parent="Theme.MaterialComponents">----android/app/src/main/res/values/styles.xml(add this same ----value night/styles.xml)
  //step4:FlutterFragmentActivity -- android/app/src/main/kotlin/MainActivity.kt

  //step5:add proguard-rules.pro--android/app
// -dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
// -dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
// -dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
// -dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
// -dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider
  //step6:initialized
*/
//https://www.youtube.com/watch?v=Mx9TCmEioAQ
