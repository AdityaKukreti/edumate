import 'package:flutter/material.dart';

Widget showNotes(String notes)
{
  List<String> splitData = notes.split('\n');
  var note = [];
  for (int i = 0; i < splitData.length; i++) {
    String data = splitData[i];
    if (data == '') {
      note.add(const Align(
        alignment: Alignment.centerLeft,
        child: Text(""),
      ));

    } else {
      if (data.contains('<h>')) {
        data = data.replaceAll('<h>', '');
        data = data.replaceAll('</h>', '');
        note.add(Align(
          alignment: Alignment.centerLeft,
          child: Text(
            data,
            style: const TextStyle(
                fontWeight: FontWeight.w800, fontSize: 16),
          ),
        ));

      } else if (data.contains('<s>')) {
        data = data.replaceAll('<s>', '');
        data = data.replaceAll('</s>', '');
        note.add(Align(
          alignment: Alignment.centerLeft,
          child: Text(
            data,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ));

      } else {
        note.add(Align(
          alignment: Alignment.centerLeft,
          child: Text(
            data,
            style: const TextStyle(fontSize: 14),
          ),
        ));

      }
    }
  }
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      children: [
        for (int i = 0; i < note.length; i++)
          note[i]
      ],
    ),
  );
}

class OldNotesContainer extends StatefulWidget {
  const OldNotesContainer({super.key, required this.videoTitle, required this.channelName, required this.channelThumbnail, required this.notes});
  final String videoTitle;
  final String channelName;
  final String channelThumbnail;
  final String notes;

  @override
  State<OldNotesContainer> createState() => _OldNotesContainerState();
}

class _OldNotesContainerState extends State<OldNotesContainer> {
  bool showMore = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 20, left: 20, right: 20),
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.videoTitle,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                 widget.channelThumbnail,
                  width: 30,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.channelName,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          showMore?Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: showNotes(widget.notes)
            ):SizedBox(),

          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                setState(() {
                  showMore = !showMore;
                });
              },
              icon:  Icon(showMore?Icons.arrow_drop_up:Icons.arrow_drop_down),
            ),
          ),
        ],
      ),
    );
  }
}