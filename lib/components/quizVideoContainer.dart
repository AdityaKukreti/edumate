import 'package:flutter/material.dart';
import 'package:hackdu/pages/quizGeneration.dart';

class QuizVideo extends StatefulWidget {
  const QuizVideo(
      {super.key,
      required this.videoTitle,
      required this.videoThumbnail,
      required this.channelThumbnail,
      required this.channedTitle,
      required this.videoId});

  final String videoTitle;
  final String videoThumbnail;
  final String channelThumbnail;
  final String channedTitle;
  final String videoId;

  @override
  State<QuizVideo> createState() => _QuizVideoState();
}

class _QuizVideoState extends State<QuizVideo> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return QuizGenerationPage(videoId: widget.videoId);
        }));
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
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.videoThumbnail,
                width: 135,
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
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      widget.videoTitle,
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
                        widget.channelThumbnail,
                        width: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.only(right: 5),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(widget.channedTitle,
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
