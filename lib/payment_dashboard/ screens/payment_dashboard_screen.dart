import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stripepayment/add_card_and_show_card_screen/screens/add_new_card_and_show_card_screen.dart';
import 'package:stripepayment/payment_dashboard/controller/home_controller.dart';
import '../../core/stripe_service.dart';

class PaymentDashboard extends StatelessWidget {
   PaymentDashboard({super.key});
final PaymentDashboardController paymentDashboard=Get.put(PaymentDashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Welcome to SecurePay",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Manage your payments effortlessly and securely. Enter an amount to get started or save a payment method for future transactions.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            // Input field for amount
            TextField(
              decoration: InputDecoration(
                labelText: "Payment Amount",
                labelStyle: const TextStyle(color: Colors.deepPurple),
                hintText: "Enter the amount (e.g., 100)",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
                prefixIcon: const Icon(Icons.attach_money, color: Colors.deepPurple),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: ()  async {
                paymentDashboard.isOneTimePayment.value=true;

               await StripeService.instance.setupPaymentMethod();
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.purpleAccent],
                  ),
                ),
                child: const Text(
                  "Proceed to Payment",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(() => PaymentMethod(),

                  transition: Transition.rightToLeftWithFade, // Animation transition
                  duration: const Duration(milliseconds: 600),
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.purpleAccent],
                  ),
                ),
                child: const Text(
                  "Save Card Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Informative section
            const Text(
              "Your payment information is secure and encrypted. We do not store sensitive data on our servers.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.lock, color: Colors.deepPurple, size: 40),
          ],
        ),
      ),
    );
  }
}
