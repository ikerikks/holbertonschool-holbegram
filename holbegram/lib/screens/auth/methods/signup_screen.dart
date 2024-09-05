import 'package:flutter/material.dart';
import '../../../widgets/text_field.dart';
import './login_screen.dart';
import '../../../methods/auth_methods.dart';
import './upload_image_screen.dart';


class SignUp extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final bool _passwordVisible;
  final Key? key;

  const SignUp({
    this.key,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.passwordConfirmController,
    bool passwordVisible = true,
  }) : _passwordVisible = passwordVisible;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordVisible = true;

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.usernameController.dispose();
    widget.passwordController.dispose();
    widget.passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget._passwordVisible;
  }

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
            const Text('Sign up to see photos and videos\nfrom your friends.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20)),
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
                    controller: widget.usernameController,
                    isPassword: false,
                    hintText: 'Full Name',
                    keyboardType: TextInputType.text,
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
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: widget.passwordConfirmController,
                    isPassword: !_passwordVisible,
                    hintText: 'Confirm Password',
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
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      // ***** Interactions SIGN UP CLICK ***********
                      onPressed: () async {
                        String email = widget.emailController.text.trim();
                        String username = widget.usernameController.text.trim();
                        String password = widget.passwordController.text.trim();
                        String confirmPassword = widget.passwordConfirmController.text.trim();
                        String signupResult = await AuthMethode().signUpUser(
                          email: email, 
                          password: password,
                          confirmPassword: confirmPassword,
                          username: username,
                        );

                        if (signupResult == "success") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("$signupResult: Account created !"),
                              backgroundColor: const Color.fromARGB(218, 25, 189, 66),
                            ),
                          );
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => AddPicture(
                              email: email, 
                              password: password, 
                              username: username
                            )),
                          );
                        } else {
                          print("ERROR GETTED: $signupResult");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(signupResult),
                              backgroundColor: const Color(0xDAE22518),
                            ),
                          );
                        }
                      },
                      // ********************************************
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Have an account?'),
                      TextButton(
                        onPressed: () {
                          // Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                emailController: TextEditingController(),
                                passwordController: TextEditingController()
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(218, 226, 37, 24)),
                        ),
                      ),
                      // Flexible(
                      //   flex: 0,
                      //   child: Container(),
                      // ),
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
