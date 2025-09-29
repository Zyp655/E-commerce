import 'package:e_commerce/View/Role_based_login/User/User%20Profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'user_app_home_screen.dart';
class UserAppMainScreen extends StatefulWidget {
  const UserAppMainScreen({super.key});

  @override
  State<UserAppMainScreen> createState() => _UserAppMainScreenState();
}

class _UserAppMainScreenState extends State<UserAppMainScreen> {
    int selectedIndex=0;
    final List pages=[
      const UserAppHomeScreen(),
      const Scaffold(),
      const UserProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(

        unselectedItemColor:  Colors.black26,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex:selectedIndex ,
        onTap: (value){
          setState(() {
            selectedIndex=value;
          });
        },
        elevation: 0,
        backgroundColor: Colors.white,
        items:[
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Iconsax.search_normal),
          //   label: 'Search',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.notification),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}
