import 'package:e_commerce/View/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.asset("assets/Screenshot 2025-07-21 193648.png"),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ) ,
                  ),

                  //password
                  const SizedBox(height: 20,),
                  TextField(
                    controller:passwordController ,
                    decoration: InputDecoration(
                      labelText: 'password',
                      border: OutlineInputBorder(),
                    ) ,
                  ),

                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child:ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SignupScreen()));
                        },
                        child: Text('Login'),
                    )
                  ),

                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Dont have an account',
                        style: TextStyle(fontSize: 18),
                      ),
                      InkWell(
                        onTap: (){},
                        child: const Text(
                          'Sign up here',
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