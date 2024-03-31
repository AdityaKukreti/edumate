import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackdu/pages/Quiz/resultPage.dart';

class Questions extends StatefulWidget {
  const Questions(
      {super.key,
      required this.data,
      required this.videoId,
      required this.videoTitle,
      required this.videoThumbnail,
      required this.channelTitle,
      required this.channelThumbnail});

  final Map<String, dynamic> data;
  final String videoId;
  final String videoTitle;
  final String videoThumbnail;
  final String channelTitle;
  final String channelThumbnail;

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  bool optionA = false;
  bool optionB = false;
  bool optionC = false;
  bool optionD = false;
  int questionNo = 1;
  bool error = false;
  Map<String, List<String>> answers = {
    'Question 1': ['', '', ''],
    'Question 2': ['', '', ''],
    'Question 3': ['', '', ''],
    'Question 4': ['', '', ''],
    'Question 5': ['', '', ''],
    'Question 6': ['', '', ''],
    'Question 7': ['', '', ''],
    'Question 8': ['', '', ''],
    'Question 9': ['', '', ''],
    'Question 10': ['', '', '']
  };

  void setAnswer(String option) {
    answers['Question $questionNo']?[0] = option;
  }

  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 10; i++) {
      answers['Question $i']?[1] = widget.data['Question $i']['Correct Answer'];
      answers['Question $i']?[2] = widget.data['Question $i']['Explanation'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          "Question $questionNo",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            Card(
              color: Colors.grey[100],
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Text(
                    widget.data['Question $questionNo']['Question'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: true,
                        groupValue: optionA,
                        onChanged: (value) {
                          setState(() {
                            optionA = value!;
                            optionB = false;
                            optionC = false;
                            optionD = false;
                            setAnswer('A');
                          });
                        },
                      ),
                      Flexible(
                        child: Text(
                          widget.data['Question $questionNo']['Option A'],
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: true,
                        groupValue: optionB,
                        onChanged: (value) {
                          setState(() {
                            optionA = false;
                            optionB = value!;
                            optionC = false;
                            optionD = false;
                            setAnswer('B');
                          });
                        },
                      ),
                      Flexible(
                        child: Text(
                          widget.data['Question $questionNo']['Option B'],
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: true,
                        groupValue: optionC,
                        onChanged: (value) {
                          setState(() {
                            optionA = false;
                            optionB = false;
                            optionC = value!;
                            optionD = false;
                            setAnswer('C');
                          });
                        },
                      ),
                      Flexible(
                        child: Text(
                          widget.data['Question $questionNo']['Option C'],
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: true,
                        groupValue: optionD,
                        onChanged: (value) {
                          setState(() {
                            optionA = false;
                            optionB = false;
                            optionC = false;
                            optionD = value!;
                            setAnswer('D');
                          });
                        },
                      ),
                      Flexible(
                        child: Text(
                          widget.data['Question $questionNo']['Option D'],
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        error ? "Select an option to proceed" : "",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const Spacer(
              flex: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    if (questionNo != 1) {
                      questionNo -= 1;
                      optionA = answers['Question $questionNo']?[0] == 'A'
                          ? true
                          : false;
                      optionB = answers['Question $questionNo']?[0] == 'B'
                          ? true
                          : false;
                      optionC = answers['Question $questionNo']?[0] == 'C'
                          ? true
                          : false;
                      optionD = answers['Question $questionNo']?[0] == 'D'
                          ? true
                          : false;
                      error = false;
                    }

                    setState(() {});
                  },
                  minWidth: MediaQuery.of(context).size.width * 0.4,
                  height: 60,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    "Previous",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    if (optionA || optionB || optionC || optionD) {
                      error = false;
                      if (questionNo != 10) {
                        questionNo += 1;
                        optionA = false;
                        optionB = false;
                        optionC = false;
                        optionD = false;
                      } else if (questionNo == 10) {
                        CollectionReference quizDB = FirebaseFirestore.instance
                            .collection('quizHistory');

                        quizDB.add({
                          'uid': FirebaseAuth.instance.currentUser?.uid,
                          'videoTitle': widget.videoTitle,
                          'videoThumbnail': widget.videoThumbnail,
                          'channelTitle': widget.channelTitle,
                          'channelThumbnail': widget.channelThumbnail,
                          'videoId': widget.videoId,
                          'timeStamp': Timestamp.now(),
                          'questions': widget.data,
                          'answers': answers
                        });

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return ResultPage(
                              questions: widget.data, answers: answers);
                        }));
                      }
                    } else {
                      error = true;
                    }
                    setState(() {});
                  },
                  minWidth: MediaQuery.of(context).size.width * 0.4,
                  height: 60,
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
