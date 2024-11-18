import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stripepayment/core/stripe_keys.dart';


class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<void> setupPaymentMethod() async {
    try {
      String? setupIntentClientSecret = await _createSetupIntent();

      if (setupIntentClientSecret == null) {
        log('Setup Intent creation failed');
        return;
      }

      log('Setup Intent Created: $setupIntentClientSecret');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          setupIntentClientSecret: setupIntentClientSecret,
          merchantDisplayName: "Bd Calling IT",
        ),
      );

      await _confirmSetupIntent(setupIntentClientSecret);
    } catch (e) {
      log('Setup Failed: $e');
    }
  }
  Future<String?> _createSetupIntent() async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "payment_method_types[]": "card",
        // Uncomment if associating with a customer
        // "customer": "cus_yourCustomerIdHere",
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/setup_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
          },
        ),
      );

      if (response.data != null) {
        log('Setup Intent Response: ${response.data}');
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      log('Error creating SetupIntent: $e');
      return null;
    }
  }
  Future<void> _confirmSetupIntent(String setupIntentClientSecret) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      log('Setup Successful!');

      await _getSetupDetails(setupIntentClientSecret);
    } catch (e) {
      log('Setup Confirmation Failed: $e');
    }
  }

  Future<void> _getSetupDetails(String setupIntentClientSecret) async {
    try {
      final Dio dio = Dio();
      final setupIntentId = setupIntentClientSecret.split('_secret')[0];

      log('Setup Intent ID: $setupIntentId');

      var response = await dio.get(
        "https://api.stripe.com/v1/setup_intents/$setupIntentId",
        options: Options(
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded'
          },
        ),
      );

      log('Response Status: ${response.statusCode}');
      log('Response Data: ${response.data}');

      // Check if the response has data and payment method
      if (response.data != null && response.data['payment_method'] != null) {
        String paymentMethodId = response.data['payment_method'];

        // // Add a null check for cardModelList.value.data
        // if (cardMethodController.cardModelList.value.data != null &&
        //     cardMethodController.cardModelList.value.data!.isNotEmpty) {
        //
        //   addNewCard(
        //     paymentMethodId,
        //     cardMethodController.cardModelList.value.data![0].customerId.toString(),
        //   );
        // } else {
        //   cardData(paymentMethodId);
        // }

        cardData(paymentMethodId);
        log('Payment Method ID: $paymentMethodId');
      }
    } catch (e) {
      log('Failed to retrieve setup details: $e');
    }
  }


  Future<void> cardData(String paymentMethodId) async {
    var accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3M2IxYTg5YjlhOTJkMjRhN2FkYzg0ZCIsImVtYWlsIjoieWFzaW45OUBnbWFpbC5jb20iLCJyb2xlIjoic3R1ZGVudCIsImlhdCI6MTczMTkyNjY2NiwiZXhwIjoxNzMyMDEzMDY2fQ.FV2dRFvkV6-Ve85146vLoOx3VwwoRJBbezwhLRfmiDQ";


    final url =
    Uri.parse('https://employee-beryl.vercel.app/api/v1/stripe/save-card');

    final body = jsonEncode({"paymentMethodId": paymentMethodId});

    try {
      EasyLoading.show();
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        log('Response:.... ${responseData['message']}');
        log('Status code: ${response.statusCode}');
        log('Status code200: ${response.body}');
        paymentConfirm(paymentMethodId);
      } else {
        log('Failed to create customer: ${response.body}');
      }
    } catch (error) {
      log('Error: $error');
    }finally{
      EasyLoading.dismiss();
    }
  }
  Future<void> paymentConfirm(String pmId) async {
    var accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3M2IxYTg5YjlhOTJkMjRhN2FkYzg0ZCIsImVtYWlsIjoieWFzaW45OUBnbWFpbC5jb20iLCJyb2xlIjoic3R1ZGVudCIsImlhdCI6MTczMTkyNjY2NiwiZXhwIjoxNzMyMDEzMDY2fQ.FV2dRFvkV6-Ve85146vLoOx3VwwoRJBbezwhLRfmiDQ";

    final url = Uri.parse('https://employee-beryl.vercel.app/api/v1/stripe/buy-token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':accessToken.toString(),
    };
    final body = jsonEncode({
      "amount": 50,
      "paymentMethodId":pmId
    });
   log(body);
    try {

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          // final String paymentId=responseData["data"]["paymentIntentId"];
          Get.snackbar(
            "Success",
            "Your payment is successful.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.deepPurple,
            colorText: Colors.white,
            icon: const Icon(Icons.check_circle, color: Colors.green),
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.all(10),
            borderRadius: 8,
          );


        } else {
          EasyLoading.show(
            status: 'Please check your card information',
          );
        }
      } else {
        log('Request failed with status: ${response.body}');
      }
    } catch (e) {
      log('An error occurred: $e');
    }
  }


  // Future<void> addNewCard(String paymentMethodId, String customerId) async {
  //   var accessToken = StorageService.token;
  //
  //   if (accessToken == null || accessToken.isEmpty) {
  //     log("Error: Access token is null or empty");
  //     return;
  //   }
  //
  //   final url = Uri.parse(
  //       'https://employee-beryl.vercel.app/api/v1/stripe/save-new-card');
  //
  //   final body = jsonEncode(
  //       {"customerId": customerId, "paymentMethodId": paymentMethodId});
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': accessToken
  //       },
  //       body: body,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       log('Response:.... ${responseData['message']}');
  //       log('Status code: ${response.statusCode}');
  //       log('Status code200: ${response.body}');
  //       final CardMethodController cardMethodController =
  //       Get.put(CardMethodController());
  //       cardMethodController.getCardMethod();
  //       Get.snackbar(
  //         "Success",
  //         "Card added successfully",
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: AppColors.primary,
  //         colorText: Colors.white,
  //         icon: const Icon(Icons.check_circle, color: Colors.green),
  //         duration: const Duration(seconds: 3),
  //         margin: const EdgeInsets.all(10),
  //         borderRadius: 8,
  //       );
  //     } else {
  //       log('Failed to create customer: ${response.body}');
  //     }
  //   } catch (error) {
  //     log('Error: $error');
  //   }
  // }
}
