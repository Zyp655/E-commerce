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
    static const List pages=[
      UserAppHomeScreen(),
      Scaffold(body: Center(child: Text('Search Page'))),
      Scaffold(body: Center(child: Text('Notification Page'))),
      Scaffold(body: Center(child: Text('Profile Page'))),
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
          BottomNavigationBarItem(
            icon: Icon(Iconsax.search_normal),
            label: 'Search',
          ),
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
