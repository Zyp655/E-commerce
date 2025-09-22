import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/View/Role_based_login/Admin/Model/add_items_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final addItemProvider= StateNotifierProvider<AddItemNotifer,AddItemState>((ref){
  return AddItemNotifer ();
});

class AddItemNotifer extends StateNotifier {
  AddItemNotifer():super(AddItemState()){
    
  }
  
  final CollectionReference items = FirebaseFirestore.instance.collection('items');
  final CollectionReference categoriesCollection= FirebaseFirestore.instance.collection('Category');


  
}