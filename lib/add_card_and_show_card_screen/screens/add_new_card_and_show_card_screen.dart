import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stripepayment/payment_dashboard/controller/home_controller.dart';
import '../../core/stripe_service.dart';
import '../controller/controller.dart';

class PaymentMethod extends StatelessWidget {
  PaymentMethod({super.key});
  final PaymentDashboardController paymentDashboardController=Get.put(PaymentDashboardController());

  final CardController controller = Get.put(CardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Card Button
            GestureDetector(
              onTap: ()async {
                paymentDashboardController.isOneTimePayment.value=false;

                await StripeService.instance.setupPaymentMethod();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Add New Card',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Section Title
            const Text(
              'Your Saved Cards',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const SizedBox.shrink()
                    : controller.cardModelList.value.data != null
                        ? ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              final cardData =
                                  controller.cardModelList.value.data?[index];
                              return GestureDetector(
                                onTap: () {},
                                child: buildCardTile(cardData!.displayBrand.toString(), cardData.last4.toString()),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 12),
                            itemCount:
                                controller.cardModelList.value.data?.length ??
                                    0,
                          )
                        : const Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.credit_card_off,
                                      color: Colors.grey, size: 48),
                                  SizedBox(height: 16),
                                  Text(
                                    'No saved cards found.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Tap "Add New Card" to save a payment method.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardTile(String cardBrand, String maskedNumber) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:  Colors.grey.shade300,
          width:  2 ,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.credit_card, color: Colors.deepPurple, size: 32),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardBrand,
                  style: const TextStyle(
                    color: Color(0xff344054),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "**** **** **** $maskedNumber"   ,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff667085),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
