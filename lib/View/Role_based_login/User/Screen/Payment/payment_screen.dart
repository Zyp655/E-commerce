import 'package:e_commerce/View/Role_based_login/User/Screen/Payment/add_payment.dart';
import 'package:flutter/material.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Methods'
        ),
      ),
      body: SizedBox(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddPaymentMethod()
              ),
            );
          },
        child: const Icon(Icons.add,size: 30,),
      ),
    );
  }
}
