import 'package:e_commerce/Core/Common/Utils/colors.dart';
import 'package:e_commerce/Core/Provider/cart_provider.dart';
import 'package:e_commerce/View/Role_based_login/User/Screen/User%20Activity/Widget/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dotted_line/dotted_line.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cp = ref.watch(cartService);
    final carts = cp.carts.reversed.toList();
    return Scaffold(
      backgroundColor: fbackgroundColor1,
      appBar: AppBar(
        backgroundColor: fbackgroundColor1,
        elevation: 0,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: carts.isEmpty
                ? Center(
                    child: Text(
                      ' Your cart is empty',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: carts.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: CartItems(cart: carts[index]),
                        ),
                      );
                    },
                  ),
          ),
          if (carts.isNotEmpty) _buildSummarySection(context, cp),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context, CartProvider cp) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Delivery',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Expanded(child: DottedLine()),
              SizedBox(width: 10),
              Text(
                '\$4.99',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Total order',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 10),
              Expanded(child: DottedLine()),
              SizedBox(width: 10),
              Text(
                '\$${((cp.totalCart()).toStringAsFixed(2))}',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 22,
                  letterSpacing: -1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          MaterialButton(
            color: Colors.black54,
            height: 70,
            minWidth: MediaQuery.of(context).size.width - 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              _showOrderConfirmationDialog(context, cp);
            },
            child: Text(
              'Pay \$${((cp.totalCart() + 4.99).toStringAsFixed(2))}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderConfirmationDialog(BuildContext context, CartProvider cp) {
    String? addressError;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Confirm your Order'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListBody(
                      children: cp.carts.map((cartItem) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${cartItem.productData['name']} x ${cartItem.quantity}',
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    Text(
                      'Total payable price: \$${(cp.totalCart() + 4.99).toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Selected payment method',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                
                    const Text(
                      'Add your Delivery Address',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'enter your address',
                        errorText: addressError,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: (){},
                    child: const Text('Confirm'),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: const Text('cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
