import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../Services/auth_service.dart';
import '../../../login_screen.dart';

AuthService authService=AuthService();

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white
      ) ,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .snapshots(),
                    builder: (context , snapshot){
                      if(!snapshot.hasData || !snapshot.data!.exists){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final user = snapshot.data!;
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: CachedNetworkImageProvider(
                              'assets/Auth/avatar profile.jpg'
                            ),
                          ),
                          Text(
                            user['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              height: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user['email'],
                            style: const TextStyle(
                              height: 0.5,
                            ),
                          )
                        ],
                      );
                    }
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              Column(
                children: [
                  GestureDetector(
                    child: const ListTile(
                      leading: Icon(
                        Icons.change_circle_rounded,
                        size: 30,
                      ),
                      title: Text(
                        'Order',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: const ListTile(
                      leading: Icon(
                        Icons.payments,
                        size: 30,
                      ),
                      title: Text(
                        'Payment method',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: const ListTile(
                      leading: Icon(
                        Icons.info,
                        size: 30,
                      ),
                      title: Text(
                        'About Us',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      authService.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder:(_) => const LoginScreen()
                        )
                      );
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        size: 30,
                      ),
                      title: Text(
                        'Log Out',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
