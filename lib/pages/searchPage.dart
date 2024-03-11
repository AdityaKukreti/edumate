import 'package:flutter/material.dart';
import 'package:hackdu/components/drawer.dart';
import '../api.dart';
import '../components/videoCell.dart';

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
      drawer:  const MyDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [

              widget.isPressed
                  ? widget.gettingResult?SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              ):api.fdata.isNotEmpty
                      ? (Expanded(
                          child: ListView.builder(
                            itemCount: api.fdata.length,
                            itemBuilder: (BuildContext context, int index) {
                              dynamic videoData =
                                  api.fdata[(index + 1).toString()];

                              return VideoCell(
                                videoId: videoData['id']['videoId'],
                                videoThumbnail: videoData['snippet']
                                    ['thumbnails']['high']['url'],
                                channelThumbnail:
                                    videoData["channel_thumbnail"],
                                videoTitle: videoData['snippet']['title'],
                                channelName: videoData['snippet']
                                    ['channelTitle'],
                                viewCount: videoData['items'][0]['statistics']
                                    ['viewCount'],
                                serialNo: "${index + 1}",
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
                                    fontWeight: FontWeight.w500, fontSize: 18),
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
