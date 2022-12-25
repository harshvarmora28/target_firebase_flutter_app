import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:groupie_chatapp_firebase/helper/helper_function.dart';
import 'package:groupie_chatapp_firebase/pages/auth/register_page.dart';
import 'package:groupie_chatapp_firebase/pages/home_page.dart';
import 'package:groupie_chatapp_firebase/service/auth_service.dart';
import 'package:groupie_chatapp_firebase/service/database_service.dart';
import 'package:groupie_chatapp_firebase/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 23, 21, 19),
      backgroundColor: Colors.black,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ))
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 55),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Target",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Login now to see what they are talking!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      Image.asset("assets/target_logo_transparent.png"),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: textInputDecoration.copyWith(
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                            )),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        // check the validation
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "Please enter a valid email";
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).primaryColor,
                            )),
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Password must be at least 6 characters long";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              elevation: 0,
                              padding: const EdgeInsets.only(top: 14, bottom: 14)),
                          child: const Text("Sign In",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          onPressed: () {
                            login();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text.rich(TextSpan(
                        text: "Don't have an account?  ",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Register here",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 213, 255, 88),
                                  fontWeight: FontWeight.w500,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, const RegisterPage());
                                })
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginUserWithEmailandPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);
          // saving the values to our shared preferences
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserNameSF(
            snapshot.docs[0]['fullName']
          );
          await HelperFunction.saveUserEmailSF(email);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
