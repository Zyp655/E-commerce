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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset("assets/Screenshot 2025-07-21 194635.png"),
                const SizedBox(height: 20,),
                TextField(
                  controller: nameController,
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
                      onPressed: (){},
                      child: Text('Sign up'),
                    )
                ),
                const SizedBox(height: 15,),
                //dropdown for selecting the role
                DropdownButtonFormField(
                  decoration: const  InputDecoration(
                    labelText: "Role",
                    border: OutlineInputBorder(),),
                    items: ["Admin","user"].map((role){
                      return DropdownMenuItem(
                          value: role,
                          child:Text(role),
                      );
                }).toList(),
                    onChanged: (String? newValue){}
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