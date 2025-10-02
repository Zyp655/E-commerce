import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../Models/cart_model.dart';

final cartService = ChangeNotifierProvider<CartProvider>(
      (ref) => CartProvider(),
);

class CartProvider extends ChangeNotifier {
  List<CartModel> _carts = [];
  List<CartModel> get carts => _carts;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CartProvider(){
    loadCartItems();
  }

  void reset() {
    _carts = [];
    notifyListeners();
  }

  final userId = FirebaseAuth.instance.currentUser?.uid;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  Future<void> addCart(String productId,
      Map<String, dynamic> productData,
      String selectedColor,
      String selectedSize,) async {
    int index = _carts.indexWhere(
          (elements) => elements.productId == productId,
    );
    if (index != -1) {
      var existingItem = _carts[index];
      _carts[index] = CartModel(
        productId: productId,
        productData: productData,
        quantity: 1,
        selectedColor: selectedColor,
        selectedSize: selectedSize,
      );
      await _updateCartInFirebase(productId, _carts[index].quantity);
    } else {
      _carts.add(
        CartModel(
          productId: productId,
          productData: productData,
          quantity: 1,
          selectedColor: selectedColor,
          selectedSize: selectedSize,
        ),
      );
      await _firestore.collection('userCart').doc(productId).set({
        'productData': productData,
        'quantity': 1,
        'selectedColor': selectedColor,
        'selectedSize': selectedSize,
        'uid': userId,
      });
    }
    notifyListeners();
  }

  Future<void> addQuantity(String productId) async {
    int index = _carts.indexWhere((element) => element.productId == productId);
    _carts[index].quantity += 1;
    await _updateCartInFirebase(productId, _carts[index].quantity);
  }

  Future<void> decreaseQuantity(String productId) async {
    int index = _carts.indexWhere((element) => element.productId == productId);
    _carts[index].quantity -= 1;
    if (_carts[index].quantity <= 0) {
      _carts.removeAt(index);
      await _firestore.collection('userCart').doc(productId).delete();
    } else {
      await _updateCartInFirebase(productId, _carts[index].quantity);
    }
    notifyListeners();
  }

  bool productExist(String productId) {
    return _carts.any((element) => element.productId == productId);
  }

  double totalCart() {
    double total = 0;
    for (var i = 0; i < _carts.length; i++) {
      final finalPrice = num.parse(
        (_carts[i].productData['price'] *
            (1 - _carts[i].productData['discountPercentage'] / 100))
            .toStringAsFixed(2),
      );
      total += _carts[i].quantity * (finalPrice);
    }
    return total;
  }
  Future<void> saveOrder(String userId , BuildContext context , paymentMethodId, finalPrice , address) async{
    if(_carts.isEmpty) return;
    final paymentRef= FirebaseFirestore.instance
      .collection('User Payment Method')
      .doc(paymentMethodId);
    try{
      await FirebaseFirestore.instance.runTransaction((transaction) async{
        final snapshot = await transaction.get(paymentRef);
        if(!snapshot.exists){
          throw Exception('Payment method not found');
        }
        final currentBalance = snapshot['balance'] as num;
        if (currentBalance < finalPrice){
          throw Exception('Insufficient funds');
        }
        transaction.update(paymentRef, {
          'balance':currentBalance-finalPrice,
        });
        final orderData={
          'userId':userId,
          'items':_carts.map((cartItem){
            return{
              'productId':cartItem.productId,
              'quantity':cartItem.quantity,
              'selectedColor':cartItem.selectedColor,
              'selectedSize':cartItem.selectedSize,
              'name':cartItem.productData['name'],
              'price':cartItem.productData['price'],
            };
          }).toList(),
          'totalPrice':finalPrice,
          'status':'pending',
          'createdAt':FieldValue.serverTimestamp(),
          'adress':address,
        };
        final orderRef=FirebaseFirestore.instance.collection('Orders').doc();
            transaction.set(orderRef, orderData);
      });
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<void> loadCartItems() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('userCart')
          .where('uid', isEqualTo: userId)
          .get();
      _carts = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CartModel(
            productId: doc.id,
            productData: data['productData'],
            quantity: data['quantity'],
            selectedColor: data['selectedColor'],
            selectedSize: data['selectedSize'],
        );
      }).toList();
    }catch(e){
      print(e.toString());
    }
    notifyListeners();
  }
  Future<void> deleteCartItem(String productId) async{
    int index =_carts.indexWhere((element)=> element.productId == productId);
    if(index != -1){
      _carts.removeAt(index);
      await _firestore.collection('userCart').doc(productId).delete();
      notifyListeners();
    }
  }

  Future<void> _updateCartInFirebase(String productId, int quantity) async {
    try {
      await _firestore.collection('userCart').doc(productId).update({
        'quantity': quantity,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
