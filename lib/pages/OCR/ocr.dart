import 'dart:io';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/api.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  State<OCRScreen> createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  File? imageFile;
  String ocrData = "";
  TextEditingController controller = TextEditingController();
  bool imagePicked = false;
  List<String> conversations = [];

  Future<void> _pickImageFromGalleryAndUpload() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imagePicked = true;
      });
    }
  }

  Future<void> _pickImageFromCameraAndUpload() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(
        () {
          imageFile = File(pickedFile.path);
          imagePicked = true;
        },
      );
    }
  }

  Future<void> sendData() async {
    String text;
    bool wasImage = false;
    if (imagePicked) {
      wasImage = true;
      list.add(BubbleNormalImage(
        isSender: true,
        color: Colors.grey.shade300,
        image: Image.file(
          imageFile!,
        ),
        id: '',
      ));
    }

    list.add(BubbleNormal(
      margin: EdgeInsets.symmetric(vertical: 5),
      text: controller.text,
      color: Colors.grey.shade300,
    ));
    text = controller.text;
    setState(() {
      imagePicked = false;
      controller.clear();
    });
    if (conversations.length == 6) {
      conversations.removeAt(0);
    }
    conversations.add("User: $text");
    text += "   Previous chat for context: " + conversations.toString();
    Map<dynamic, dynamic> data;
    if (wasImage) {
      data = await api.uploadImageToServer(imageFile!.path, text, ocrData);
    } else {
      data = await api.uploadImageToServer("", text, ocrData);
    }

    text = data['text'];
    if (conversations.length == 6) {
      conversations.removeAt(0);
    }
    // conversations.add("User: ${controller.text}");
    conversations.add("System: $text");
    print(conversations);
    ocrData = data['ocrResponse'];
    setState(() {
      list.add(BubbleNormal(
        text: text,
        color: Colors.black,
        textStyle: TextStyle(color: Colors.white),
        isSender: false,
      ));
    });
  }

  List<Widget> list = [
    BubbleNormal(
      text: "Hi, I am your assistant, feel free to ask any doubt.",
      textStyle: TextStyle(color: Colors.white),
      color: Colors.black87,
      isSender: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("AI Assistant"),
      ),
      bottomNavigationBar: Container(
        height: imagePicked ? 220 : 80,
        // padding: EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (imagePicked)
              Stack(
                children: [
                  Container(
                    height: 125,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        opacity: const AlwaysStoppedAnimation(.4),
                        imageFile!,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        imagePicked = false;
                        setState(() {});
                      },
                      icon: const Icon(
                        CupertinoIcons.xmark,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            Container(
              height: 72,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(60)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    maxLength: 100,
                    minLines: 1,
                    maxLines: 1,
                    controller: controller,
                    // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: InputDecoration(
                      hintText: "Message...",
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width *
                              (controller.text.isNotEmpty ? 0.7 : 0.625)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      // contentPadding:
                      //     EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),

                      helperStyle: TextStyle(fontSize: 0),
                    ),
                  ),
                  (controller.text.isEmpty)
                      ? Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  _pickImageFromGalleryAndUpload();
                                },
                                icon: const Icon(
                                  CupertinoIcons.paperclip,
                                  size: 24,
                                )),
                            IconButton(
                                onPressed: () {
                                  _pickImageFromCameraAndUpload();
                                },
                                icon: const Icon(
                                  CupertinoIcons.camera_fill,
                                  size: 24,
                                )),
                          ],
                        )
                      : IconButton(
                          onPressed: () {
                            sendData();
                          },
                          icon: Icon(Icons.send)),
                  // IconButton(onPressed: () {}, icon: Icon(Icons.send)),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              for (int i = 0; i < list.length; i++) list[i],
            ],
          ),
        ),
      ),
    );
  }
}
