import 'package:flutter/material.dart';

class QuizVideo extends StatefulWidget {
  const QuizVideo({super.key});

  @override
  State<QuizVideo> createState() => _QuizVideoState();
}

class _QuizVideoState extends State<QuizVideo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Map<String, dynamic> data = await api.getVideoDetails(post['videoId']);
        details.videoId = post['videoId'];
        details.videoThumbnail = data['thumbnail_url'];
        details.channelThumbnail = data["channel_thumbnail_url"];
        details.videoTitle = data['title'];
        details.channelName = data['channel_title'];
        details.viewCount = data['view_count'];
        details.likeCount = data['like_count'];
        details.videoDescription = data['description'];
        details.uploadDate = data['published_at'].toString().substring(0, 10);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayer(
                      videoId: details.videoId,
                    )));
      },
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (value) {},
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                post['videoThumbnail'],
                width: 120,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      post['videoTitle'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        post['channelThumbnail'],
                        width: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.only(right: 5),
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(post['channelName'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                overflow: TextOverflow.ellipsis))),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
