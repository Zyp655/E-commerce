import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/View/Role_based_login/User/Screen/User%20Activity/Order/my_order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../../Widgets/show_scackbar.dart';

Future<void> placeOrder(
  String productId,
  Map<String, dynamic> productData,
  String selectedColor,
  String selectedSize,
  String paymentMethodId,
  num finalPrice,
  String address,
  BuildContext context,
) async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) {
    showSnackBar(context, 'User not log in, pleas log in place an order');
    return;
  }
  final paymentRef = FirebaseFirestore.instance
      .collection('User Payment Method')
      .doc(paymentMethodId);
  try {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(paymentRef);
      if (!snapshot.exists) {
        throw Exception('Payment method not found');
      }
      final currentBalance = snapshot['balance'] as num;
      if (currentBalance < finalPrice) {
        throw Exception('Insufficient funds');
      }
      transaction.update(paymentRef, {'balance': currentBalance - finalPrice});
      final orderData = {
        'userId': userId,
        'items': [
          {
            'productId': productId,
            'quantity': 1,
            'selectedColor': selectedColor,
            'selectedSize': selectedSize,
            'name': productData['name'],
            'price': productData['price'],
          },
        ],

        'totalPrice': finalPrice,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'address': address,
      };
      final orderRef = FirebaseFirestore.instance.collection('Orders').doc();
      transaction.set(orderRef, orderData);
    });
    showSnackBar(context, 'Order placed successfully');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyOrderScreen()),
    );
  }on FirebaseAuthException catch (e) {
    showSnackBar(context, 'Firebase Erro: ${e.message}');
  } on Exception catch(e){
    showSnackBar(context, 'Error: ${e.toString()}');
  }
}
