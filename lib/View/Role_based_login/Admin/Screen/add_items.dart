import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../Widgets/my_button.dart';
import '../../../../Widgets/show_scackbar.dart';
import '../Controller/add_items_controller.dart';

class AddItems extends ConsumerWidget {
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _priceController=TextEditingController();
  final TextEditingController _sizeController=TextEditingController();
  final TextEditingController _colorController=TextEditingController();
  final TextEditingController _discountpercentageController=TextEditingController();

  AddItems({super.key});




  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final state = ref.watch(addItemProvider);
    final notifier = ref.read(addItemProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add new items'),
      ),
      body: Padding(
          padding: const EdgeInsets.
          symmetric(
              horizontal:15
          ),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            children: [
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: state.imagePath!=null ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                        File(state.imagePath!),
                        fit:BoxFit.cover,
                    ),
                  ):state.isLoading ?
                    CircularProgressIndicator():
                      GestureDetector(
                        onTap: notifier.pickImage,
                        child: const Icon(Icons.camera_alt, size: 20,),
                      ),
                ),
              ),

              SizedBox(height: 10,),
              TextField(
                controller:_nameController ,
                decoration:const  InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 10,),
              TextField(
                controller:_priceController ,
                decoration:const  InputDecoration(
                  labelText: 'price',
                  border: OutlineInputBorder(),
                ),
              ),
              
              DropdownButtonFormField<String>(
                  initialValue: state.selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Selected Category',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: notifier.setSelectedCategory,
                  items: state.categories.map((String category){
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
              ),

              SizedBox(height: 10,),
              TextField(
                controller:_colorController ,
                decoration:const  InputDecoration(
                  labelText: 'Color(comma separated)',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value){
                  notifier.addColor(value);
                  _colorController.clear();
                },
              ),

              Wrap(
                spacing: 8,
                children: state.colors.map(
                      (color)=>Chip(
                      onDeleted: ()=>notifier.removeColor(color),
                      label: Text(color)
                  ),
                ).toList(),
              ),

              SizedBox(height: 10,),
              TextField(
                controller:_sizeController ,
                decoration:const  InputDecoration(
                  labelText: 'Sized (comma separated)',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value){
                  notifier.addSize(value);
                  _sizeController.clear();
                },
              ),

              Wrap(
                spacing: 8,
                children: state.sizes.map(
                    (size)=>Chip(
                      onDeleted: ()=>notifier.removeSize(size),
                        label: Text(size)
                    ),
                ).toList(),
              ),

              Row(children: [
                Checkbox(
                    value: state.isDiscounted,
                    onChanged: notifier.toogleDiscount
                ),
                const Text('apply discount'),
              ],),

              if(state.isDiscounted)
                Column(
                  children: [
                    TextField(
                      controller: _discountpercentageController,
                      decoration: const InputDecoration(
                        labelText: 'Discount percentage (%)',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value){
                        notifier.setDiscountPercentage(value);
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 20,),
              const SizedBox(height: 10,),

              state.isLoading ?Center(
                child: CircularProgressIndicator(),
              ) :Center(
                child: MyButton(
                  onTab: ()async{
                    try{
                      await notifier.uploadAndSaveItem(
                          _nameController.text,
                          _priceController.text
                      );
                      showSnackBar(context, 'Item added successfully');
                      Navigator.of(context).pop();
                    }catch(e){
                      showSnackBar(context, 'Error $e');
                    }
                  },
                  buttonText: 'Save item',
                ),
              ),
            ],
      ),
      ),
    );
  }
}
