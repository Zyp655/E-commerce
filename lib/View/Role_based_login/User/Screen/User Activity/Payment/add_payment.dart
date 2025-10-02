import 'package:e_commerce/Widgets/my_button.dart';
import 'package:e_commerce/Widgets/show_scackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({super.key});

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(
    mask: '**** **** **** ****',
    filter: {'*': RegExp(r'[0-9]')},
  );
  double balance = 0.0;
  String? selectedPaymentSystem;
  Map<String, dynamic>? selectedPaymentSystemData;
  final _formKey = GlobalKey<FormState>();

  Future<List<Map<String, dynamic>>> fetchPaymentSystems() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('payment_methods')
        .get();
    return snapshot.docs
        .map((doc) => {'name': doc['name'], 'image': doc['image']})
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Payment Method')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                FutureBuilder(
                  future: fetchPaymentSystems(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: (${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('no payment systems available');
                    }
                    return DropdownButton<String>(
                      elevation: 2,
                      value: selectedPaymentSystem,
                      hint: Text('Selected payment System'),
                      items: snapshot.data!.map((system) {
                        return DropdownMenuItem<String>(
                          value: system['name'],
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: system['image'],
                                width: 30,
                                height: 30,
                                errorWidget: (context, stackTrace, error) =>
                                    const Icon(Icons.error),
                              ),
                              const SizedBox(width: 10),
                              Text(system['name']),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentSystem = value;
                          selectedPaymentSystemData = snapshot.data!.firstWhere(
                            (system) => system['name'] == value,
                          );
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _userNameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Card holder name',
                    hintText: 'vd:nguyen van A',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length < 6) {
                      return 'provide your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Card number',
                    hintText: 'vd:1343 1234 1422 3221 ',
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: [maskFormatter],
                  validator: (value) {
                    if (value == null ||
                        value.replaceAll(' ', '').length != 16) {
                      return 'card number must be exactly 16 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _balanceController,
                  decoration: InputDecoration(
                    labelText: 'Balance',
                    prefixText: '\$',
                    hintText: '40',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => balance = double.tryParse(value) ?? 0.0,
                ),
                const SizedBox(height: 20),
                MyButton(
                  onTab: () => addPaymentMethod(),
                  buttonText: 'Add payment method',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addPaymentMethod() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null && selectedPaymentSystemData != null) {
      final paymentCollection = FirebaseFirestore.instance.collection(
        'User Payment Method',
      );
      final existingMethods = await paymentCollection
          .where('userId', isEqualTo: userId)
          .where('paymentSystem', isEqualTo: selectedPaymentSystemData!['name'])
          .get();
      if (existingMethods.docs.isNotEmpty) {
        showSnakeBar(context, 'u have already added this payment method');
        return;
      }
      await paymentCollection.add({
        'userName': _userNameController.text.trim(),
        'cardNumer': _cardNumberController.text.trim(),
        'balance': balance,
        'userId': userId,
        'paymentSystem': selectedPaymentSystemData!['name'],
        'image': selectedPaymentSystemData!['image'],
      });
      showSnakeBar(context, 'payment method successfully added');
      Navigator.pop(context);
    } else {
      showSnakeBar(context, 'failded to add payment method.please try again');
    }
  }
}
