import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/add_items_model.dart';

final addItemProvider= StateNotifierProvider<AddItemNotifer,AddItemState>((ref){
  return AddItemNotifer ();
});

class AddItemNotifer extends StateNotifier <AddItemState> {
  AddItemNotifer():super(AddItemState()){
    fetchCategory();
  }

  final CollectionReference items = FirebaseFirestore.instance.collection('items');
  final CollectionReference categoriesCollection= FirebaseFirestore.instance.collection('Category');

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void clearSuccess() {
    state = state.copyWith(isSuccess: false);
  }

  void pickImage() async{
    state = state.copyWith(errorMessage: null);
    try{
      final pickedFile= await ImagePicker().pickImage(source: ImageSource.gallery);
      if(pickedFile!=null){
        state=state.copyWith(imagePath:pickedFile.path);
      }
    }catch(e){
      state = state.copyWith(errorMessage: 'Error picking image: $e');
    }
  }

  void setSelectedCategory(String? category){
    state=state.copyWith(selectedCategory:category);
  }

  void addSize (String size){
    state=state.copyWith(sizes:[...state.sizes, size]);
  }

  void removeSize (String size){
    state=state.copyWith(sizes: state.sizes.where((s)=> s!=size).toList());
  }

  void addColor (String color){
    state=state.copyWith(colors: [...state.colors , color]);
  }

  void removeColor (String color){
    state=state.copyWith(colors: state.colors.where((c)=> c!=color).toList());
  }

  void toogleDiscount(bool? isDiscounted){
    state=state.copyWith(isDiscounted: isDiscounted ?? false);
  }

  void setDiscountPercentage(String percentage){
    state=state.copyWith(discountPercentage: percentage);
  }

  void  setLoading(bool isLoading){
    state =state.copyWith(isLoading: isLoading);
  }

  Future<void> fetchCategory() async{
    state = state.copyWith(errorMessage: null);
    try{
      QuerySnapshot snapshot=await categoriesCollection.get();
      List<String> categories =
      snapshot.docs.map((doc)=> doc['name'] as String).toList();
      state=state.copyWith(categories:categories);
    }catch(e){
      state = state.copyWith(errorMessage: 'Error fetching categories: $e');
    }
  }

  Future<void> uploadAndSaveItem(String name, String price) async{
    if(name.isEmpty ||
        price.isEmpty ||
        state.imagePath== null ||
        state.selectedCategory == null ||
        state.sizes.isEmpty ||
        state.colors.isEmpty||
        (state.isDiscounted && state.discountPercentage == null)){
      state = state.copyWith(errorMessage: 'Please fill all required fields and upload an image.');
      return;
    }

    state=state.copyWith(isLoading: true, errorMessage: null, isSuccess: false);

    try{
      final fileName=DateTime.now().microsecondsSinceEpoch.toString();
      final reference = FirebaseStorage.instance.ref().child('image/$fileName');
      await reference.putFile(File(state.imagePath!));
      final imageUrl = await reference.getDownloadURL();

      final String uid=FirebaseAuth.instance.currentUser!.uid;
      final parsedPrice = int.tryParse(price) ?? 0;
      final parsedDiscount = state.isDiscounted
          ? (int.tryParse(state.discountPercentage!) ?? 0)
          : 0;


      DocumentReference docRef = await items.add({
        'name':name,
        'price':parsedPrice,
        'picture':imageUrl,
        'uploadedBy':uid,
        'category':state.selectedCategory,
        'size':state.sizes,
        'color':state.colors,
        'isDiscounted':state.isDiscounted,
        'discountPercentage':parsedDiscount,
        'description':'',
        'isCheck': false,
      });

      await docRef.update({'id': docRef.id});



      state = state.copyWith(
        imagePath: null,
        selectedCategory: null,
        sizes: [],
        colors: [],
        isDiscounted: false,
        discountPercentage: null,
        isSuccess: true,
      );

    }catch(e){
      print('Error saving item: $e');
      state = state.copyWith(errorMessage: 'Error saving item: ${e.toString()}');
    }finally{
      state =state.copyWith(isLoading: false);
    }
  }

}