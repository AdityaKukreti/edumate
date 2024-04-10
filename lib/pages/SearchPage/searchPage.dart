import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackdu/pages/OCR/ocr.dart';
import 'package:hackdu/pages/SearchPage/Components/drawer.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/api.dart';
import 'Components/videoCell.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  bool isPressed = false;
  bool gettingResult = true;
  TextEditingController controller = TextEditingController();

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // _pickImageAndUpload();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OCRScreen();
          }));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.grey[300],
        child: Icon(CupertinoIcons.camera_fill),
      ),
      appBar: AppBar(
        title: TextField(
          controller: widget.controller,
          style: const TextStyle(
            fontSize: 19,
          ),
          textAlignVertical: TextAlignVertical.bottom,
          textInputAction: TextInputAction.go,
          onSubmitted: (text) async {
            setState(() {
              widget.gettingResult = true;
              widget.isPressed = true;
            });
            await api.getSearchResults(widget.controller.text);

            setState(() {
              widget.isPressed = true;
              widget.gettingResult = false;
            });
          },
          decoration: InputDecoration(
            hintText: "Search",
            alignLabelWithHint: true,
            hintStyle: const TextStyle(),
            prefixIcon: const Icon(
              Icons.search,
            ),
            constraints: const BoxConstraints(maxHeight: 45),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.1),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        surfaceTintColor: Colors.white,
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              widget.isPressed
                  ? widget.gettingResult
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                        )
                      : api.fdata.isNotEmpty
                          ? (Expanded(
                              child: ListView.builder(
                                itemCount: api.fdata.length,
                                itemBuilder: (BuildContext context, int index) {
                                  dynamic videoData =
                                      api.fdata[(index + 1).toString()];

                                  return Column(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: Colors.grey[100],
                                        child: VideoCell(
                                          videoId: videoData['id']['videoId'],
                                          videoThumbnail: videoData['snippet']
                                              ['thumbnails']['high']['url'],
                                          channelThumbnail:
                                              videoData["channel_thumbnail"],
                                          videoTitle: videoData['snippet']
                                              ['title'],
                                          channelName: videoData['snippet']
                                              ['channelTitle'],
                                          viewCount: videoData['items'][0]
                                              ['statistics']['viewCount'],
                                          serialNo: "${index + 1}",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ))
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off_rounded,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "No videos found",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_library_rounded,
                            size: 30,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Search your video in the search bar",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
