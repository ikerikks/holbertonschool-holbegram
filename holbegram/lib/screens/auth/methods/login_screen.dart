import 'package:flutter/material.dart';
import 'package:holbegram/widgets/text_field.dart';
import './signup_screen.dart';
import 'package:holbegram/methods/auth_methods.dart';
// import 'package:holbegram/screens/widgets/text_field.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class LoginScreen extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool _passwordVisible;
  final Key? key;

  const LoginScreen({
    this.key,
    required this.emailController,
    required this.passwordController,
    bool passwordVisible = true,
  }) : _passwordVisible = passwordVisible;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget._passwordVisible;
  }

  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 28),
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 50,
              ),
            ),
            Image.network('../../assets/images/logo.webp', width: 80, height: 60),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  TextFieldInput(
                    controller: widget.emailController,
                    isPassword: false,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: widget.passwordController,
                    isPassword: !_passwordVisible,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      alignment: Alignment.bottomLeft,
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: const Color.fromARGB(218, 226, 37, 24),
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(218, 226, 37, 24)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder( borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      onPressed: () async {
                        String email = widget.emailController.text.trim();
                        String password = widget.passwordController.text.trim();
                        String loginResult = await AuthMethode().login(
                          context: context,
                          email: email,
                          password: password,
                        );

                        if (loginResult == "success") {
                          // Navigator.pushReplacementNamed(context, '/home');
                          print("ENTERED ! $loginResult");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Login"),
                              backgroundColor: Color.fromARGB(218, 25, 189, 66)
                            ),
                          );
                        } else {
                          print("ERROR GETTED: $loginResult");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(loginResult),
                              backgroundColor: const Color(0xDAF5281A)
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Forgot your login details?'),
                      const SizedBox( width: 5,),
                      const Text(
                        'Get help logging in',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                        flex: 0,
                        child: Container(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(thickness: 2),
                   Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(
                                  emailController: TextEditingController(),
                                  usernameController: TextEditingController(),
                                  passwordController: TextEditingController(),
                                  passwordConfirmController: TextEditingController(),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xDAE22518)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Flexible(child: Divider(thickness: 2)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('OR'),
                      ),
                      Flexible(child: Divider(thickness: 2)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network('../../assets/images/google-logo.png', width: 40, height: 40),
                      const SizedBox(width: 8),
                      const Text('Sign in with Google'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
