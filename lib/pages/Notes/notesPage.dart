import 'package:flutter/material.dart';
import 'package:hackdu/pages/Notes/Components/notesContainer.dart';
import 'package:hackdu/database/database.dart';
import 'package:hackdu/pages/VideoPlayer/videoPlayerPage.dart';
import '../../components/api.dart';
import '../../components/videoDetails.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key, required this.uid});

  final String uid;

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    NotesDatabase database = NotesDatabase();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.5),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                        child: Text(
                          "No notes to show here.",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5),
                        ),
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
                                    videoThumbnail: post['videoThumbnail'],
                                    videoId: post['videoId'],
                                    onTap: () async {
                                      Map<String, dynamic> data = await api
                                          .getVideoDetails(post['videoId']);
                                      details.videoId = post['videoId'];
                                      details.videoThumbnail =
                                          data['thumbnail_url'];
                                      details.channelThumbnail =
                                          data["channel_thumbnail_url"];
                                      details.videoTitle = data['title'];
                                      details.channelName =
                                          data['channel_title'];
                                      details.viewCount = data['view_count'];
                                      details.likeCount = data['like_count'];
                                      details.videoDescription =
                                          data['description'];
                                      details.uploadDate = data['published_at']
                                          .toString()
                                          .substring(0, 10);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => VideoPlayer(
                                                    videoId: details.videoId,
                                                  )));
                                    })
                                : const SizedBox();
                          }));
                }),
          ],
        ),
      ),
    );
  }
}
