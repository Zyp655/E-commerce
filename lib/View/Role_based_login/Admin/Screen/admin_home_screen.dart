import 'package:e_commerce/View/Role_based_login/Admin/Screen/add_items.dart';

import '../../../../Services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../login_screen.dart';
final AuthService _authService=AuthService();
class AdminHomeScreen extends StatelessWidget{
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[70],
      appBar: AppBar(
        title: const Text('Admin Screen',),
        backgroundColor: Colors.cyanAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to the Admin Page'),
              ElevatedButton(
                onPressed: (){
                  _authService.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(
                        builder: (_)=>const LoginScreen(),
                  ));
                },
                child: const Text('Sign out'),
              )
            ],

          )
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,

        onPressed: ()async{
          await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>  AddItems(),
              ));
        },
        child: const Icon(Icons.add, color: Colors.purpleAccent,),
      ),

    );
  }
}

