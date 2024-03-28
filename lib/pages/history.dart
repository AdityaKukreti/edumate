import 'package:flutter/material.dart';

import '../database/database.dart';

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
            SizedBox(
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
                  print(posts);

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

                                onTap: () {},
                                child: Container(
                                  width: double.maxFinite,
                                  margin:
                                  const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          post['videoThumbnail'],
                                          width: 140,
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
                                                  0.575,
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Text(
                                                post['videoTitle'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17),
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
                                                  width: 25,
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
                                                      0.5,
                                                  child: Text(
                                                      post['channelName'],
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