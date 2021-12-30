import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:hrapp/res/constant.dart';
import 'package:hrapp/utils/firebase.dart';
import 'package:lottie/lottie.dart';

import 'components/snackbars.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  ResultState _state = ResultState.noData;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _state == ResultState.loading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/load.json', width: 200),
                  const Text("Try to login...")
                ],
              )
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/hr.jpg'),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [colorAccent.withOpacity(0.2), Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.3,
                    left: 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sign in',
                            style: kHeadingThree.copyWith(color: Colors.white)),
                        Text('Welcome Back!',
                            style: kHeadingOne.copyWith(
                                color: Colors.white, fontSize: 32)),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(32),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                InputForm(
                                  controller: emailController,
                                  validator: (value) {
                                    if (!value!.contains('@')) {
                                      return 'Email not valid';
                                    }
                                  },
                                  label: 'Email',
                                  labelStyle: kHeadingThree,
                                ),
                                const SizedBox(height: 16),
                                InputForm(
                                  obsecure: true,
                                  controller: passController,
                                  validator: (value) {
                                    if (value!.length < 4) {
                                      return 'Minimal 8 character';
                                    }
                                    return null;
                                  },
                                  label: 'Password',
                                  labelStyle: kHeadingThree,
                                  counter: TextButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await FirebaseUtils().resetPassword(
                                              context, emailController.text);
                                        }
                                      },
                                      child: const Text('Reset Password')),
                                ),
                                const SizedBox(height: 16),
                                SignInButton(Buttons.Email,
                                    text: 'Sign up with Email',
                                    onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(
                                        () => _state = ResultState.loading);
                                    try {
                                      await _auth
                                          .createUserWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passController.text,
                                          )
                                          .then((_) => FirebaseUtils()
                                              .sendEmailVerification(context))
                                          .then((_) =>
                                              _auth.currentUser!.emailVerified
                                                  ? Get.offAllNamed('/')
                                                  : Get.toNamed('/onboard'));
                                    } on FirebaseAuthException catch (e) {
                                      showSnackbar(
                                          context,
                                          e.message ??
                                              'Make sure your information are right');
                                      setState(
                                          () => _state = ResultState.error);
                                    }
                                  }
                                }),
                                Row(
                                  children: [
                                    Expanded(child: Divider()),
                                    Text('  or  '),
                                    Expanded(child: Divider())
                                  ],
                                ),
                                SignInButton(
                                  Buttons.Email,
                                  text: 'Sign in with Email',
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(
                                          () => _state = ResultState.loading);
                                      try {
                                        await _auth
                                            .signInWithEmailAndPassword(
                                                email: emailController.text,
                                                password: passController.text)
                                            .then((_) => FirebaseUtils()
                                                .sendEmailVerification(context))
                                            .then((_) =>
                                                _auth.currentUser!.emailVerified
                                                    ? Get.offAllNamed('/')
                                                    : null);
                                      } on FirebaseAuthException catch (e) {
                                        showSnackbar(
                                            context,
                                            e.message ??
                                                'Make sure your information are right');
                                        setState(
                                            () => _state = ResultState.error);
                                      }
                                    }
                                  },
                                ),
                                SignInButton(
                                  Buttons.Google,
                                  text: 'Sign in with Google',
                                  onPressed: () async {
                                    setState(
                                        () => _state = ResultState.loading);
                                    try {
                                      await FirebaseUtils().signInWithGoogle();
                                      Get.offAllNamed('/');
                                    } on FirebaseAuthException catch (e) {
                                      print(e.message);
                                      setState(
                                          () => _state = ResultState.error);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}

class InputForm extends StatelessWidget {
  const InputForm({
    Key? key,
    required this.controller,
    required this.validator,
    required this.label,
    required this.labelStyle,
    this.obsecure,
    this.counter,
  }) : super(key: key);

  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final TextStyle labelStyle;
  final bool? obsecure;
  final Widget? counter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: obsecure ?? false,
          cursorColor: colorAccent,
          decoration: InputDecoration(
              focusColor: colorAccent,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: colorAccent),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              counter: counter),
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }
}
