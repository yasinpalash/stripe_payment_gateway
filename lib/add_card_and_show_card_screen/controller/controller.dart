import 'dart:convert';
import 'dart:developer';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../models/card_models.dart';
import 'package:http/http.dart' as http;

class CardController extends GetxController {
  final Rx<CardModel> _cardModelList = CardModel().obs;
  Rx<CardModel> get cardModelList => _cardModelList;

  var accessToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3M2IxYTg5YjlhOTJkMjRhN2FkYzg0ZCIsImVtYWlsIjoieWFzaW45OUBnbWFpbC5jb20iLCJyb2xlIjoic3R1ZGVudCIsImlhdCI6MTczMTkyNjY2NiwiZXhwIjoxNzMyMDEzMDY2fQ.FV2dRFvkV6-Ve85146vLoOx3VwwoRJBbezwhLRfmiDQ";

  RxBool isLoading = false.obs;
  final url = Uri.parse('https://employee-beryl.vercel.app/api/v1/stripe/user-payment-method');

  void getCardMethod() async {
    try {
      EasyLoading.show();
      isLoading(true);

      final headers = {
        'Authorization': accessToken,
        'Content-Type': 'application/json',
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);
        _cardModelList.value = CardModel.fromJson(data);
       log(response.body);
      } else {
      log(response.body);
        EasyLoading.showError('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      EasyLoading.showError('An unexpected error occurred. Please try again.');
    } finally {
      EasyLoading.dismiss();
      isLoading(false);
    }
  }

  @override
  void onInit() {
    getCardMethod();
    super.onInit();
  }
}
