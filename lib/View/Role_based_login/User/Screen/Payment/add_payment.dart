import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({super.key});

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  String? selectedPaymentSystem;
  Map<String , dynamic>? selectedPaymentSystemData;
  final _formKey = GlobalKey<FormState>();
  Future<List<Map<String , dynamic >>> fetchPaymentSystems() async{
    QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('payment_methods').get();
    return snapshot.docs.map((doc) =>{
      'name':doc['name'],
      'image':doc['image'],
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Payment Method',
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Form(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                      child: Column(
                        key: _formKey,
                        children: [
                          FutureBuilder(
                              future: fetchPaymentSystems(),
                              builder: (context,snapshot){
                                if(snapshot.hasError){
                                  return Text(
                                    'Error: (${snapshot.error}');
                                }else if(!snapshot.hasData || snapshot.data!.isNotEmpty){
                                  return const Text('no payment systems available');
                                }
                                return DropdownButton<String>(
                                  elevation: 2,
                                    value: selectedPaymentSystem,
                                    hint: Text('Selected payment System'),
                                    items: snapshot.data!.map((system){
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
                                              Text(system['name'])
                                            ],
                                          ),
                                      );
                                    }).toList(),
                                    onChanged: (value){
                                      setState(() {
                                        selectedPaymentSystem = value;
                                        selectedPaymentSystemData = snapshot.data!
                                          .firstWhere(
                                            (system)=> system['name'] == value
                                        );
                                      });
                                    }
                                );
                              }
                          )
                        ],
                      )
                  ),
                )
            ),
          ),

      ),
    );
  }
}
