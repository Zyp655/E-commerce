import 'package:flutter/material.dart';

class AddItems extends StatelessWidget {
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _priceController=TextEditingController();
  final TextEditingController _sizeController=TextEditingController();
  final TextEditingController _colorController=TextEditingController();
  final TextEditingController _discountpercentageController=TextEditingController();

  AddItems({super.key});




  @override
  Widget build(BuildContext context) {
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
              
              DropdownButtonFormField(
                  items: items,
                  onChanged: onChanged),
              SizedBox(height: 10,),
              TextField(
                controller:_colorController ,
                decoration:const  InputDecoration(
                  labelText: 'Color(comma separated)',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 10,),
              TextField(
                controller:_sizeController ,
                decoration:const  InputDecoration(
                  labelText: 'Sized (comma separated)',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 10,),
              TextField(
                controller:_discountpercentageController ,
                decoration:const  InputDecoration(
                  labelText: 'Discount Percentage(%)',
                  border: OutlineInputBorder(),
                ),
              )
            ],
      ),
      ),
    );
  }
}
