import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackdu/pages/videoPlayerPage.dart';

import '../api.dart';
import '../videoDetails.dart';

class VideoCell extends StatelessWidget {
  const VideoCell(
      {super.key,
      required this.videoId,
      required this.videoThumbnail,
      required this.channelThumbnail,
      required this.videoTitle,
      required this.channelName,
      required this.viewCount,
      required this.serialNo});

  final String videoId;
  final String videoThumbnail;
  final String channelThumbnail;
  final String videoTitle;
  final String channelName;
  final String viewCount;
  final String serialNo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        dynamic videoData = api.fdata[serialNo];
        details.videoId = videoData['id']['videoId'];
        details.videoThumbnail =
            videoData['snippet']['thumbnails']['high']['url'];
        details.channelThumbnail = videoData["channel_thumbnail"];
        details.videoTitle = videoData['snippet']['title'];
        details.channelName = videoData['snippet']['channelTitle'];
        details.viewCount = videoData['items'][0]['statistics']['viewCount'];
        details.likeCount = videoData['items'][0]['statistics']['likeCount'];
        details.videoDescription = videoData['snippet']['description'];
        details.uploadDate =
            videoData['snippet']['publishTime'].toString().substring(0, 10);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const VideoPlayer()));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        // width: double.maxFinite,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 220,
              width: double.maxFinite,
              child: Image.network(
                videoThumbnail,
                // height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.5),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      channelThumbnail,
                      width: 35,
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.85,
                        child: Text(
                          videoTitle,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            channelName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('$viewCount views'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
