import 'package:e_commerce/Services/auth_service.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';

final AuthService _authService=AuthService();
class UserAppFirstScreen extends StatefulWidget {
  const UserAppFirstScreen({super.key});

  @override
  State<UserAppFirstScreen> createState() => _UserAppFirstScreenState();
}

class _UserAppFirstScreenState extends State<UserAppFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome User'),
            ElevatedButton(
              onPressed: (){
                _authService.signOut();
                print('sign out successfully');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(
                      builder: (_)=>const LoginScreen(),
                ));
              },
              child: const Text('Sign out'),
            )
          ],
        ),
      ),
    );
  }
}
