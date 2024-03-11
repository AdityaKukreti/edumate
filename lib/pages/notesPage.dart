import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackdu/components/notesContainer.dart';
import 'package:hackdu/database/database.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key, required this.uid});

  final String uid;

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    FirestoreDatabase database = FirestoreDatabase();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.5),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: database.getPostStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final posts = snapshot.data!.docs;

                  if (snapshot.data == null || posts.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Text("No notes to show here.",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 1.5),),
                      ),
                    );
                  }
                  return Expanded(
                      child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];

                      return (post['uid'] == widget.uid)
                          ? OldNotesContainer(
                              videoTitle: post['videoTitle'],
                              channelName: post['videoChannel'],
                              channelThumbnail: post['thumbnail'],
                              notes: post['notes'],
                            )
                          : const Text("");
                      // }
                    },
                  ));
                })
          ],
        ),
      ),
    );
  }
}
