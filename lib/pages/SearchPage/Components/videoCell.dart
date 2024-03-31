import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackdu/pages/VideoPlayer/videoPlayerPage.dart';
import '../../../components/api.dart';
import '../../../components/videoDetails.dart';

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
    CollectionReference historyDB =
        FirebaseFirestore.instance.collection('userHistory');
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
        historyDB.add({
          'videoId': details.videoId,
          'videoTitle': details.videoTitle,
          'videoThumbnail': details.videoThumbnail,
          'channelName': details.channelName,
          'uid': FirebaseAuth.instance.currentUser?.uid,
          'timeStamp': Timestamp.now(),
          'channelThumbnail': details.channelThumbnail
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayer(
                      videoId: details.videoId,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        // width: double.maxFinite,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: double.maxFinite,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  videoThumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.5),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.925,
                        child: Text(
                          videoTitle,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              channelThumbnail,
                              width: 30,
                              alignment: Alignment.center,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            channelName.substring(
                                    0,
                                    channelName.length < 20
                                        ? channelName.length
                                        : 20) +
                                (channelName.length > 20 ? '...' : ''),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
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
