import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/View/Role_based_login/User/Screen/Payment/add_payment.dart';
import 'package:e_commerce/Widgets/show_scackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? userId;
  @override
  void initState(){
    userId=FirebaseAuth.instance.currentUser?.uid;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Methods'
        ),
      ),
      body: userId == null ?const Center(
      ):SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('User Payment Method')
                .where('userId',isEqualTo: userId)
                .snapshots(),
            builder: (context,snapshot){
              if(!snapshot.hasData){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final methods = snapshot.data!.docs;
              if(methods.isEmpty){
                return const Center(
                  child: Text(
                    'No payment methods found .Pls add a payment methods',
                  ),
                );
              }
              return ListView.builder(
                itemCount: methods.length,
                itemBuilder: (context,index){
                  final method= methods[index];
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: method['image'],
                      height: 50,
                      width: 50,
                    ),
                    title: Text(
                        method['paymentSystem']
                    ),
                    subtitle: const Text(
                      'Activate',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    trailing: MaterialButton(
                        onPressed:() => _showAddFundsDialog(context, method),
                        child: const Text('Add Fund'),
                    ),
                  );
                }
              );
            }
        ),
      ),
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
  void _showAddFundsDialog(BuildContext context,DocumentSnapshot method){
    TextEditingController amoutController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Add funds'),
          content: TextField(
            controller: amoutController,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              labelText: 'Amout',
              prefixText: '\$',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              )
            ),
          ),
          actions: [
            TextButton(
                onPressed: ()=> Navigator.pop(context),
                child: const Text('Cancel'),
            ),
            TextButton(
                onPressed: () async {
                  final amout = double.tryParse(amoutController.text);
                  if(amout == null || amout <=0 ){
                    showSnakeBar(context, 'Please enter a valid positive amout');
                    return;
                  }
                  try{
                    await method.reference.update({
                      'balance': FieldValue.increment(amout),
                    });
                    Navigator.pop(context);
                        showSnakeBar(context, 'Fund Added Successfully');
                  }catch(e){
                    showSnakeBar(context, 'Error adding funds: $e');
                  }
                },
                child: Text('Add')
            ),
          ],
        ),
    );
  }
}
