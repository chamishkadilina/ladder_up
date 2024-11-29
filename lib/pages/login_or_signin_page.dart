import 'package:flutter/material.dart';
import 'package:ladder_up/providers/auth_provider.dart';
import 'package:ladder_up/widgets/show_custom_snack_bar.dart';
import 'package:ladder_up/widgets/square_tile.dart';
import 'package:ladder_up/widgets/text_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLogin = true;

  void toggleLoginMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  Future<void> _handleAuth() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      if (!_isLogin) {
        // Validation for registration
        if (_passwordController.text.trim() !=
            _confirmPasswordController.text.trim()) {
          showCustomSnackBar(
            context,
            'Passwords do not match.',
          );
          return;
        }
      }

      // Proceed with authentication
      if (_isLogin) {
        await authProvider.signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } else {
        await authProvider.signUp(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      }
    } catch (e) {
      showCustomSnackBar(
        context,
        'Authentication failed: $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Lock icon
                  const Icon(Icons.lock, size: 128),
                  const SizedBox(height: 32),

                  // Welcome message
                  Center(
                    child: Text(
                      _isLogin
                          ? 'Welcome back, you\'ve been missed!'
                          : 'Let\'s create an account for you!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Email textfield
                  MyTextField(
                    controller: _emailController,
                    hintText: 'Email Address',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 8),

                  // Password textfield
                  MyTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 8),

                  // Confirm password textfield (only for register)
                  if (!_isLogin) ...[
                    MyTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 8),
                  ],

                  // Forgot password (only for login)
                  if (_isLogin)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Forgot password logic here
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),

                  // Login/Register button
                  GestureDetector(
                    onTap: _handleAuth,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      child: Center(
                        child: Text(
                          _isLogin ? 'Log In' : 'Register',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Or continue with
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Colors.grey)),
                      const SizedBox(width: 8),
                      Text(
                        'Or Continue With',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Google and Apple sign-in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        imagePath: 'assets/ic_google.png',
                        onTap: () {
                          // Google sign-in logic
                        },
                      ),
                      const SizedBox(width: 16),
                      SquareTile(
                        imagePath: 'assets/ic_apple.png',
                        onTap: () {
                          // Apple sign-in logic
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 96),

                  // Toggle between login and register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLogin
                            ? 'Not a member? '
                            : 'Already have an account? ',
                      ),
                      GestureDetector(
                        onTap: toggleLoginMode,
                        child: Text(
                          _isLogin ? 'Register now' : 'Login now',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
