import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Questions extends StatefulWidget {
  const Questions({super.key, required this.data});

  final Map<String, dynamic> data;

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

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          "Question " + questionNo.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        )),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            Text(
              widget.data['Question ' + questionNo.toString()]['Question'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                    });
                  },
                ),
                Flexible(
                  child: Text(
                    widget.data['Question ' + questionNo.toString()]
                        ['Option A'],
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
                    });
                  },
                ),
                Flexible(
                  child: Text(
                    widget.data['Question ' + questionNo.toString()]
                        ['Option B'],
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
                    });
                  },
                ),
                Flexible(
                  child: Text(
                    widget.data['Question ' + questionNo.toString()]
                        ['Option C'],
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
                    });
                  },
                ),
                Flexible(
                  child: Text(
                    widget.data['Question ' + questionNo.toString()]
                        ['Option D'],
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              error ? "Select an option to proceed" : "",
              style: TextStyle(
                  color: Colors.red, fontSize: 17, fontWeight: FontWeight.w500),
            ),
            const Spacer(
              flex: 20,
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
                  }
                } else {
                  error = true;
                }
                setState(() {});
              },
              minWidth: MediaQuery.of(context).size.width,
              height: 60,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: const Text(
                "Next Question",
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
