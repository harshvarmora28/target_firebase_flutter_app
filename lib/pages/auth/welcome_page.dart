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
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: 430,
              child: Column(children: [
                const SizedBox(height: 24,),
                Image.asset("assets/target_vector_logo_transparent_with_text.png", height: 42,),
                Image.asset("assets/welcome_png.png")
              ]),
            ),
            Container(
                padding: const EdgeInsets.only(top: 35),
                color: Colors.black,
                child: Container(
                  padding: const EdgeInsets.only(left: 28, right: 40),
                  child: const Text(
                    "Achieving your Target",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w500),
                  ),
                )),
                const SizedBox(height: 14,),
                Container(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: const Text("Traders community in which you can discuss about each indian stock trading in indian stock exchanges individually with fellow traders.",
                  textAlign: TextAlign.start,
                   style: TextStyle(color: Color.fromARGB(195, 255, 255, 255), fontWeight: FontWeight.w300),),
                ),
                const SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 74,),
                    SizedBox(
              width: 140,
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
              width: 140,
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
                              text: "By clicking to register, you agree to our\n",
                              style:
                                 TextStyle(color: Color.fromARGB(195, 255, 255, 255), fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Terms, Data Policy.",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 213, 255, 88),
                                        fontWeight: FontWeight.w500,
                                        ),
                                        ), 
                              ],
                            ), 
                            textAlign: TextAlign.center,
                            ),
                )
          ],
        ),
      ),
    );
  }
}
