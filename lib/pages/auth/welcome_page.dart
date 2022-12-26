import 'package:flutter/material.dart';
import 'package:groupie_chatapp_firebase/pages/auth/login_page.dart';
import 'package:groupie_chatapp_firebase/pages/auth/register_page.dart';
import 'package:groupie_chatapp_firebase/widgets/widgets.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          height: 430,
        ),
        Container(
            padding: const EdgeInsets.only(top: 40),
            color: Colors.black,
            child: const Center(
              child: Text(
                "Welcome to Target",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
            )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 120,),
                SizedBox(
          width: 130,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                elevation: 0,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                padding: const EdgeInsets.only(top: 14, bottom: 14)),
            child: const Text("Sign In",
                style: TextStyle(color: Colors.black, fontSize: 16)),
            onPressed: () {
              nextScreenReplace(context, const LoginPage());
            },
          ),
        ),
        const SizedBox(width: 22,),
        SizedBox(
          width: 130,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                elevation: 0,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                padding: const EdgeInsets.only(top: 14, bottom: 14)),
            child: const Text("Register",
                style: TextStyle(color: Colors.black, fontSize: 16)),
            onPressed: () {
              nextScreenReplace(context, const RegisterPage());
            },
          ),
        ),
              ],
            ),
            const Center(
              child: Text.rich(TextSpan(
                          text: "By clicking to register, you agree to our ",
                          style:
                             TextStyle(color: Color.fromARGB(195, 255, 255, 255), fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Terms, Data Policy",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 213, 255, 88),
                                    fontWeight: FontWeight.w500,
                                    ),)
                          ],
                        )),
            )
      ],
    );
  }
}
