import 'package:e_commerce/Services/auth_service.dart';
import 'package:e_commerce/View/Role_based_login/signup_screen.dart';
import 'package:flutter/material.dart';
import 'Admin/Screen/admin_home_screen.dart';
import 'User/user_app_main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _passwordVisible = false;
  bool _isLoading = false;

  void _loginWithEmail() async {
    setState(() {
      _isLoading = true;
    });
    String? result = await _authService.login(
        email: emailController.text, password: passwordController.text);
    if (!mounted) return;

    _handleLoginResult(result);
  }

  void _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    String? result = await _authService.signInWithGoogle(context: context);
    if (!mounted) return;

    _handleLoginResult(result);
  }

  void _handleLoginResult(String? result) {
    setState(() {
      _isLoading = false;
    });

    if (result == 'Admin') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const AdminHomeScreen()));
    } else if (result == 'User') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => const UserAppMainScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $result')));
    }
  }
  void _showForgotPasswordDialog() {
    final TextEditingController resetEmailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Reset Password"),
        content: TextField(
          controller: resetEmailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: "Enter your email"),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text("Send"),
            onPressed: () async {
              if (resetEmailController.text.isEmpty) return;
              String? error = await _authService.sendPasswordResetEmail(
                  email: resetEmailController.text);
              Navigator.of(context).pop();
              if (error == null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Password reset link has been sent.")));
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Error: $error")));
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/Auth/login.png"),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _showForgotPasswordDialog,
                        child: const Text('Forgot password?'),
                      ),
                    ),
                  ),
                  if (_isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else ...[
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _loginWithEmail,
                          child: const Text('Login'),
                        )),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _loginWithGoogle,
                        icon: Image.asset('assets/Auth/google.png', height: 24),
                        label: const Text('Sign in with Google'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SignupScreen()));
                        },
                        child: const Text(
                          'Sign up now',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}

