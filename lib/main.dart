import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/View/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'View/Role_based_login/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AuthStateHandler(),
    );
  }
}
class AuthStateHandler extends  StatefulWidget{
  const AuthStateHandler({super.key});

  @override
  State<StatefulWidget> createState() =>_AuthStateHandlerState();

}

class _AuthStateHandlerState extends State<AuthStateHandler> {
  User? _currentUser;
  String? _userRole;
  @override
  void initState(){
    super.initState();
    _initializeAuthState();
  }

  void _initializeAuthState() async {
    FirebaseAuth.instance.authStateChanges().listen((user) async{
      if(!mounted) return;
      setState((){
        _currentUser=user;
        _userRole=null;
      });
      if(user!=null){
        final userDoc =await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if(!mounted)return;
        if(userDoc.exists){
          _userRole=userDoc['role'];
        }
      }
    });

  }

  @override
  Widget build(BuildContext context){
    if(_currentUser == null){
      return const  LoginScreen();
    }
    if(_userRole == null){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return _userRole == 'Admin'? AdminScreen(): UserScreen();
  }

}
