import 'package:e_commerce/Services/auth_service.dart';
import 'package:flutter/material.dart';

import 'Role_based_login/login_screen.dart';
AuthService _authService=AuthService();
class AdminScreen extends StatelessWidget{
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.blueAccent,
     appBar: AppBar(
       title: const Text('Admin Screen'),
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
               Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>const LoginScreen(),
               ));
             },
             child: const Text('Sign out'),
           )
         ],

       )
     ),

     floatingActionButton: FloatingActionButton(
         onPressed: (){},
         child: const Icon(Icons.add),
     ),

   );
  }
}

class UserScreen extends StatelessWidget{
  const UserScreen ({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('User Screen'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome User'),
            ElevatedButton(
                onPressed: (){
                  _authService.signOut();
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>const LoginScreen(),
                  ));
                },
                child: const Text('Sign out'),
            )
          ],
        ),
      ),
    );
  }}