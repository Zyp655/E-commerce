import 'package:flutter/material.dart';

class AddItems extends StatelessWidget {
  const AddItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add new items'),
      ),
      body: Padding(
          padding: EdgeInsets.
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
              )
            ],
      ),
      ),
    );
  }
}
