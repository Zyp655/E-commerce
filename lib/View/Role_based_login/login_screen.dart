import 'package:e_commerce/Services/auth_service.dart';
import 'package:e_commerce/View/Role_based_login/signup_screen.dart';
import 'package:flutter/material.dart';
import '../Admin/Screen/admin_home_screen.dart';
import '../User/app_main_screen.dart';


class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() =>_LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService=AuthService();
  bool _passwordVisible = false;
  bool _isLoading=false;
  void login()async{
    setState(() {
      _isLoading=true;
    });
    String? result =await _authService.login(
      email: emailController.text,
    password: passwordController.text
    );
    setState(() {
      _isLoading=false;
    });
    if(!mounted) return;
    if(result == 'Admin'){
      Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (_)=>const AdminHomeScreen(),
      )
      );
    }else if(result=='User'){
      Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (_)=>const AppMainScreen(),
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
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.asset("assets/Auth/login.png"),
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

                  _isLoading? const Center(
                    child: CircularProgressIndicator(),
                  ):
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child:ElevatedButton(
                        onPressed: login,
                        child: Text('Login'),
                    )
                  ),

                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dont have an account ',
                        style: TextStyle(fontSize: 18),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const SignupScreen()));
                        },
                        child: const Text(
                          '  Sign up here',

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