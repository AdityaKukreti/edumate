import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackdu/pages/account.dart';
import 'package:hackdu/pages/history.dart';
import '../pages/login.dart';
import '../pages/notesPage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeader(
                margin: EdgeInsets.zero,
                child: Text(
                  "EduMate",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25,letterSpacing: 2),
                )),
             ListTile(
              title: const Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Account",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3),
                  ),
                ],
              ),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Account();
                }));
              },
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.edit_note_rounded),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Notes",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NotesPage(
                    uid: FirebaseAuth.instance.currentUser!.uid,
                  );
                }));
              },
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.history),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "History",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3),
                  ),
                ],
              ),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return HistoryPage(uid: FirebaseAuth.instance.currentUser!.uid,);
                }
                )
    );
              },
            ),
            const Expanded(
              flex: 6,
              child: Text(""),
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.exit_to_app_rounded),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3),
                  ),
                ],
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
              },
            )
          ],
        ),
      ),
    );
  }
}
