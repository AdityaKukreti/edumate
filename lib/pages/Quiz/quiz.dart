import 'package:flutter/material.dart';
import 'package:hackdu/pages/Quiz/Components/quizVideoContainer.dart';
import '../../database/database.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.uid});

  final String uid;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    HistoryDatabase database = HistoryDatabase();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select a Video",
          style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.5),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
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
                          "No videos here to select from",
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
                          ? QuizVideo(
                              videoTitle: post['videoTitle'],
                              videoThumbnail: post['videoThumbnail'],
                              channelThumbnail: post['channelThumbnail'],
                              channelTitle: post['channelName'],
                              videoId: post['videoId'])
                          : const SizedBox();
                    },
                  ));
                }),
          ],
        ),
      ),
    );
  }
}
