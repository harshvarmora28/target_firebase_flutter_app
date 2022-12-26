import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupie_chatapp_firebase/helper/helper_function.dart';
import 'package:groupie_chatapp_firebase/pages/auth/login_page.dart';
import 'package:groupie_chatapp_firebase/pages/profile_page.dart';
import 'package:groupie_chatapp_firebase/pages/search_page.dart';
import 'package:groupie_chatapp_firebase/service/auth_service.dart';
import 'package:groupie_chatapp_firebase/service/database_service.dart';
import 'package:groupie_chatapp_firebase/widgets/group_tile.dart';
import 'package:groupie_chatapp_firebase/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunction.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunction.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, const SearchPage());
              },
              icon: const Icon(Icons.search_rounded, color: Colors.black,))
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Stocks",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
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
              userName.substring(0, 1).toUpperCase(),
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
              userName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
              color: Color.fromARGB(255, 104, 104, 104),
            ),
            ListTile(
              onTap: () {},
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group, color: Color.fromARGB(255, 192, 192, 192),),
              title: const Text(
                "Stocks",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                nextScreenReplace(
                    context,
                    ProfilePage(
                      userName: userName,
                      email: email,
                    ));
              },
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
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 23, 21, 19),
            title: const Text(
              "Add new stock",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : TextField(
                        onChanged: (val) {
                          setState(() {
                            groupName = val;
                          });
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (groupName != "") {
                    setState(() {
                      _isLoading = true;
                    });
                    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                        .createGroup(userName,
                            FirebaseAuth.instance.currentUser!.uid, groupName)
                        .whenComplete(() {
                      _isLoading = false;
                    });
                    Navigator.of(context).pop();
                    showSnackbar(
                        context, Colors.green, "Group created successfully!");
                  }
                },
                child: const Text("Create"),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
              )
            ],
          );
        });
  }

  groupList() {
    return StreamBuilder(
        stream: groups,
        builder: (context, AsyncSnapshot snapshot) {
          // make some checks
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != null) {
              if (snapshot.data['groups'].length != 0) {
                return ListView.builder(
                  itemCount: snapshot.data['groups'].length,
                  itemBuilder: (context, index) {
                      int reverseIndex = snapshot.data['groups'].length - index - 1;
                    return GroupTile(
                        groupId: getId(snapshot.data['groups'][reverseIndex]),
                        groupName: getName(snapshot.data['groups'][reverseIndex]),
                        userName: snapshot.data['fullName']);
                  },
                );
              } else {
                return noGroupWidget();
              }
            } else {
              return noGroupWidget();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        });
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You've not joined any groups, tap on the add icon to create a group or join the existing group.",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70),
          )
        ],
      ),
    );
  }
}
