import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupie_chatapp_firebase/pages/home_page.dart';
import 'package:groupie_chatapp_firebase/service/database_service.dart';
import 'package:groupie_chatapp_firebase/widgets/widgets.dart';

class GroupInfo extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String adminName;
  const GroupInfo(
      {super.key,
      required this.adminName,
      required this.groupName,
      required this.groupId});

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  Stream? members;
  @override
  void initState() {
    getMembers();
    super.initState();
  }

  getMembers() async {
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.groupId)
        .then((val) {
      setState(() {
        members = val;
      });
    });
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Group Info", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600,),),
        actions: [
          IconButton(
            color: Colors.black,
              onPressed: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Exit"),
                        content: const Text(
                            "Are you sure to want to exit the group?"),
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
                                DatabaseService(
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .toggleGroupJoin(
                                        widget.groupId,
                                        getName(widget.adminName),
                                        widget.groupName)
                                    .whenComplete(() {
                                  nextScreenReplace(context, const HomePage());
                                });
                              },
                              icon: const Icon(
                                Icons.done_rounded,
                                color: Colors.green,
                              )),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    widget.groupName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.groupName,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Admin: ${getName(widget.adminName)}", style: const TextStyle(color: Colors.white),),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 24,),
          Text("Members", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),),
          SizedBox(height: 5,),
          memberList(),
        ]),
      ),
    );
  }

  memberList() {
    return StreamBuilder(
      stream: members,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['members'] != null) {
            if (snapshot.data['members'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['members'].length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          getName(snapshot.data['members'][index])
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      title: Text(getName(snapshot.data['members'][index]), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                      subtitle: Text(getId(snapshot.data['members'][index]), style: const TextStyle(color: Colors.white70, fontSize: 12),),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("NO MEMBERS", style: TextStyle(color: Colors.white),),
              );
            }
          } else {
            return const Center(
              child: Text("NO MEMBERS", style: TextStyle(color: Colors.white),),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }
}
