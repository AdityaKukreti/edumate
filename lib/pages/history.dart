import 'package:flutter/material.dart';
import 'package:hackdu/api.dart';
import 'package:hackdu/pages/videoPlayerPage.dart';

import '../database/database.dart';
import '../videoDetails.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.uid});

  final String uid;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    HistoryDatabase database = HistoryDatabase();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "History",
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
                          "No user history to show here",
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
                          ? GestureDetector(
                              onTap: () async {
                                Map<String, dynamic> data =
                                    await api.getVideoDetails(post['videoId']);
                                details.videoId = post['videoId'];
                                details.videoThumbnail = data['thumbnail_url'];
                                details.channelThumbnail =
                                    data["channel_thumbnail_url"];
                                details.videoTitle = data['title'];
                                details.channelName = data['channel_title'];
                                details.viewCount = data['view_count'];
                                details.likeCount = data['like_count'];
                                details.videoDescription = data['description'];
                                details.uploadDate = data['published_at']
                                    .toString()
                                    .substring(0, 10);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoPlayer(
                                              videoId: details.videoId,
                                            )));
                              },
                              child: Container(
                                width: double.maxFinite,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        post['videoThumbnail'],
                                        width: 135,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.525,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              post['videoTitle'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image.network(
                                                post['channelThumbnail'],
                                                width: 30,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.45,
                                                child: Text(post['channelName'],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        overflow: TextOverflow
                                                            .ellipsis))),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const Text("");
                    },
                  ));
                })
          ],
        ),
      ),
    );
  }
}
