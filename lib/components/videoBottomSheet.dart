import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../videoDetails.dart';

class VideoBottomSheet extends StatefulWidget {
  const VideoBottomSheet({super.key});

  @override
  State<VideoBottomSheet> createState() => _VideoBottomSheetState();
}

class _VideoBottomSheetState extends State<VideoBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(onClosing: (){}, builder: (context){
      return Container(
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        height:
        MediaQuery.sizeOf(context).height * 0.5,
        child: Column(
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  const Expanded(
                    flex: 4,
                    child: Text(
                      "Description",
                      style: TextStyle(
                          fontWeight:
                          FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                          CupertinoIcons.xmark),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      "Likes",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.w600),
                    ),
                    Text(
                      details.likeCount,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.w500),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Published on",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.w600),
                    ),
                    Text(
                      details.uploadDate,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.w500),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(details.videoDescription),
          ],
        ),
      );
    });
  }
}
