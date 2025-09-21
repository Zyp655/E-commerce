import 'dart:developer';

import 'package:e_commerce/Services/auth_service.dart';
import 'package:e_commerce/View/login_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget{
  const SignupScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_SignupScreenState();

}

class _SignupScreenState extends State<SignupScreen>{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String selectedRole='User';
  bool _passwordVisible = false;
  bool _isLoading=false;

  final AuthService _authService=AuthService();
  void _signup() async{
    setState(() {
      _isLoading=true;
    });
    String? result = await _authService.signup(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        role: selectedRole,
    );
    setState(() {
      _isLoading=false;
    });
    if(!mounted) {
      return;
    }
    if(result == null){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Signup Successfully'
            ),
          )
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_)=>const LoginScreen(),
        )
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'sign up failed $result',
            ),
          )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child:SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/Screenshot 2025-07-21 194635.png"),
            const SizedBox(height: 20,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                  suffixIcon: emailController.text.isEmpty
                      ?null
                      :IconButton(
                    icon:const Icon(Icons.clear),
                    onPressed: (){
                      emailController.clear();
                      setState(() {});
                    },
                  )
              ) ,
              onChanged: (value){
                setState(() {

                });
              },
              ) ,

            const SizedBox(height: 20,),
            TextField(
              controller:nameController ,

              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                suffixIcon: nameController.text.isEmpty
                  ?null
                  :IconButton(
                    icon:const Icon(Icons.clear),
                    onPressed: (){
                      nameController.clear();
                      setState(() {});
                    },
                )
              ) ,
              onChanged: (value){
                setState(() {

                });
              },
            ),

            //password
            const SizedBox(height: 20,),
            TextField(
              controller:passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                        ?Icons.visibility
                        :Icons.visibility_off,
                    ),
                  onPressed: () {
                      setState(() {
                        _passwordVisible=!_passwordVisible;
                      });
                  },
                )
              ) ,
            ),

            const SizedBox(height: 20,),
            //dropdown for selecting the role
            DropdownButtonFormField(
              initialValue:selectedRole ,
              decoration: const  InputDecoration(
                labelText: "Role",
                border: OutlineInputBorder(),),
                items: ["Admin","User"].map((role){
                  return DropdownMenuItem(
                      value: role,
                      child:Text(role),
                  );
            }).toList(),
                onChanged: (String? newValue){
                  selectedRole=newValue!;
                }
            ),

            const SizedBox(height: 15,),

            _isLoading? Center(child: CircularProgressIndicator(),):
            SizedBox(
                width: double.infinity,
                child:ElevatedButton(
                  onPressed: _signup,
                  child: Text('Sign up'),
                )
            ),

            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'already have an account',
                  style: TextStyle(fontSize: 18),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (_)=>const LoginScreen()));
                  },
                  child: const Text(
                      'login up here',
                      style:TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:Colors.blue,
                        letterSpacing: -1,
                      )
                  ),
                )
              ],
            )
          ],
        ),
        )
      ),
    );
  }

}