import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentGateWay extends StatefulWidget {
  const PaymentGateWay({super.key});

  @override
  State<PaymentGateWay> createState() => _PaymentGateWayState();
}

class _PaymentGateWayState extends State<PaymentGateWay> {
  Razorpay razorpay = Razorpay();

  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // TODO: implement initState
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('SUCCESS PAYMENT');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('ERROR PAYMENT');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              var options = {
                'key': 'rzp_test_4Y7Nhiv0EAzD3m',
                'amount': 100,
                'name': 'Acme Corp.',
                'description': 'Fine T-Shirt',
                'prefill': {
                  'contact': '8888888888',
                  'email': 'test@razorpay.com'
                }
              };
              razorpay.open(options);
            },
            child: const Text('Pay')),
      ),
    );
  }
}
