import 'package:flutter/material.dart';
import 'package:groupie_chatapp_firebase/pages/auth/login_page.dart';
import 'package:groupie_chatapp_firebase/pages/home_page.dart';
import 'package:groupie_chatapp_firebase/service/auth_service.dart';
import 'package:groupie_chatapp_firebase/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({super.key, required this.email, required this.userName});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 21, 19),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text("Profile",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
      ),
      drawer: Drawer(
      backgroundColor: Color.fromARGB(255, 23, 21, 19),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            CircleAvatar(
            radius: 64,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.userName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.userName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                  nextScreen(context, const HomePage());
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group, color: Color.fromARGB(255, 192, 192, 192),),
              title: const Text(
                "Groups",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
              },
              selected: true,
              selectedColor: Theme.of(context).primaryColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.person, color: Color.fromARGB(255, 192, 192, 192),),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure to want to logout?"),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel_rounded,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () async {
                                await authService.signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                    (route) => false);
                              },
                              icon: const Icon(
                                Icons.done_rounded,
                                color: Colors.green,
                              )),
                        ],
                      );
                    });
                // authService.signOut().whenComplete(() {
                //   nextScreenReplace(context, const LoginPage());
                // });
              },
              selectedColor: Theme.of(context).primaryColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.logout, color: Color.fromARGB(255, 192, 192, 192),),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
            radius: 64,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.userName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
            const SizedBox(height: 40,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Username", style: TextStyle(fontSize: 17, color: Colors.white),),
              Text(widget.userName, style: TextStyle(fontSize: 17, color: Colors.white),),
            ],
            ),
            const Divider(height: 20, color: Color.fromARGB(255, 104, 104, 104),),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Email", style: TextStyle(fontSize: 17, color: Colors.white),),
              Text(widget.email, style: TextStyle(fontSize: 17, color: Colors.white),),
            ],
            ),

          ],
        ),
      ),
    );
  }
}
