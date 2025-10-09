import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentMethodList extends StatefulWidget {
  final String? selectedPaymentMethodId;
  final double? selectedPaymentBalance;
  final double? finalAmout;
  final Function(String?, double?) onPaymentMethodSelected;

  const PaymentMethodList({
    super.key,
    required this.selectedPaymentMethodId,
    required this.selectedPaymentBalance,
    required this.finalAmout,
    required this.onPaymentMethodSelected,
  });

  @override
  State<PaymentMethodList> createState() => _PaymentMethodListState();
}

class _PaymentMethodListState extends State<PaymentMethodList> {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return SizedBox(
      height: 150,
      width: double.maxFinite,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('User Payment Method')
              .where('userId', isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final paymentMethod = snapshot.data!.docs;
            if (paymentMethod.isEmpty) {
              return Center(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'no payment methods available',
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Click here to add',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            decorationColor: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
                itemCount: paymentMethod.length,
                itemBuilder: (context, index) {
                  var payment = paymentMethod[index];
                  return Material(
                    color: widget.selectedPaymentMethodId == payment.id
                        ? Colors.blue
                        : Colors.transparent,
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  payment['image']),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                      title: Text(payment['paymentSystem']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          availableBalance(
                              payment['balance'], widget.finalAmout)
                        ],
                      ),
                      selected: widget.selectedPaymentMethodId == payment.id,
                      onTap: () {
                        widget.onPaymentMethodSelected(
                            payment.id, (payment['balance'] as num).toDouble()
                        );
                      },
                    ),
                  );
                }
            );
          }
      ),
    );
  }

  availableBalance(balance, finalAmout) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (balance > finalAmout)
          const Text(
            'Active',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        if (balance < finalAmout)
          const Text(
            'Insufficent Balance',
            style: TextStyle(
              color: Colors.red,
            ),
          )
      ],
    );
  }
}
