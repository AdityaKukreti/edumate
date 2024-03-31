import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.questions, required this.answers});

  final Map<String, dynamic> questions;
  final Map<String, dynamic> answers;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();

    for (int i = 1; i <= 10; i++) {
      if (widget.answers['Question $i']?[0] ==
          widget.answers['Question $i']?[1]) {
        score += 1;
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  int score = 0;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Center(
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.black,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            height: 60,
            child: const Text(
              "Homepage",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        )
      ],
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Your Score",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 35),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "$score/10",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                            color: Colors.green),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Your answers",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            for (int i = 1; i <= 10; i++)
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Card(
                                  color: Colors.grey[100],
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Q$i. ' +
                                              widget.questions['Question $i']
                                                  ['Question'],
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: widget.answers['Question $i']
                                                        ?[0] ==
                                                    'A'
                                                ? (widget.answers['Question $i']
                                                            ?[1] ==
                                                        'A'
                                                    ? Colors.green[100]
                                                    : Colors.red[100])
                                                : (widget.answers['Question $i']
                                                            ?[1] ==
                                                        'A'
                                                    ? Colors.green[100]
                                                    : Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio(
                                                value: "A",
                                                groupValue: widget
                                                    .answers['Question $i']?[0],
                                                onChanged: (value) {},
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.questions[
                                                          'Question $i']
                                                      ['Option A'],
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: widget.answers['Question $i']
                                                        ?[0] ==
                                                    'B'
                                                ? (widget.answers['Question $i']
                                                            ?[1] ==
                                                        'B'
                                                    ? Colors.green[100]
                                                    : Colors.red[100])
                                                : (widget.answers['Question $i']
                                                            ?[1] ==
                                                        'B'
                                                    ? Colors.green[100]
                                                    : Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio(
                                                value: "B",
                                                groupValue: widget
                                                    .answers['Question $i']?[0],
                                                onChanged: (value) {},
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.questions[
                                                          'Question $i']
                                                      ['Option B'],
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: widget.answers['Question $i']
                                                        ?[0] ==
                                                    'C'
                                                ? (widget.answers['Question $i']
                                                            ?[1] ==
                                                        'C'
                                                    ? Colors.green[100]
                                                    : Colors.red[100])
                                                : (widget.answers['Question $i']
                                                            ?[1] ==
                                                        'C'
                                                    ? Colors.green[100]
                                                    : Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio(
                                                value: "C",
                                                groupValue: widget
                                                    .answers['Question $i']?[0],
                                                onChanged: (value) {},
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.questions[
                                                          'Question $i']
                                                      ['Option C'],
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: widget.answers['Question $i']
                                                        ?[0] ==
                                                    'D'
                                                ? (widget.answers['Question $i']
                                                            ?[1] ==
                                                        'D'
                                                    ? Colors.green[100]
                                                    : Colors.red[100])
                                                : (widget.answers['Question $i']
                                                            ?[1] ==
                                                        'D'
                                                    ? Colors.green[100]
                                                    : Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Radio(
                                                value: "D",
                                                groupValue: widget
                                                    .answers['Question $i']?[0],
                                                onChanged: (value) {},
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.questions[
                                                          'Question $i']
                                                      ['Option D'],
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Explanation: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          widget.answers['Question $i']![2],
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
