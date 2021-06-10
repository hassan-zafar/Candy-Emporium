import 'package:candy_emporium/database/database.dart';
import 'package:candy_emporium/screens/auth/widgets/decoration_functions.dart';
import 'package:candy_emporium/screens/auth/widgets/providerButtons.dart';
import 'package:candy_emporium/screens/auth/widgets/sign_in_up_bar.dart';
import 'package:candy_emporium/screens/home.dart';
import 'package:candy_emporium/services/authentication_service.dart';
import 'package:candy_emporium/tools/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/palette.dart';
import 'title.dart';

class SignIn extends StatefulWidget {
  SignIn({
    Key key,
    @required this.onRegisterClicked,
  }) : super(key: key);

  final VoidCallback onRegisterClicked;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  final _textFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // final isSubmitting = context.isSubmitting();
    return
        // SignInForm(
        //   child:
        Form(
      key: _textFormKey,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: LoginTitle(
                  title: 'Welcome\nBack',
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: signInInputDecoration(hintText: 'Email'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: signInInputDecoration(hintText: 'Password'),
                    ),
                  ),
                  SignInBar(
                    label: 'Sign in',
                    isLoading: _isLoading,
                    onPressed: () {
                      _handleLogin();
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        widget.onRegisterClicked?.call();
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: Palette.darkBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    const Text(
                      "or sign in with",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      height: 14.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ProviderButton(
                        //   context: context,
                        //   signInType: "google",
                        // ),
                        // ProviderButton(
                        //   context: context,
                        //   signInType: "apple",
                        // ),
                      ],
                    ),
                    const Spacer(),
                    // InkWell(
                    //   splashColor: Colors.white,
                    //   onTap: () {
                    //     onRegisterClicked?.call();
                    //   },
                    //   child: RichText(
                    //     text: const TextSpan(
                    //       text: "Don't have an account? ",
                    //       style: TextStyle(color: Colors.black54),
                    //       children: <TextSpan>[
                    //         TextSpan(
                    //           text: 'SIGN UP',
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.black),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // ),
      ),
    );
  }

  void _handleLogin() async {
    final _form = _textFormKey.currentState;
    if (_form == null) {
      return null;
    }
    if (_form.validate()) {
      setState(() {
        _isLoading = true;
      });

      final String email = _emailController.text;
      final String password = _passwordController.text;
      String userId = await AuthenticationService()
          .logIn(email: email, password: password)
          .onError((error, stackTrace) {
        errorToast(message: "Please Try again");
        setState(() {
          _isLoading = false;
          _emailController.clear();
          _passwordController.clear();
        });
        return null;
      });
      await DatabaseMethods()
          .fetchUserInfoFromFirebase(uid: userId)
          .then((value) => setState(() {
                _isLoading = false;
                Get.off(() => HomeScreen());
              }));
    }
  }
}
