import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackdu/components/api.dart';
import 'package:hackdu/pages/Quiz/questions.dart';

class QuizGenerationPage extends StatefulWidget {
  const QuizGenerationPage(
      {super.key,
      required this.videoId,
      required this.videoTitle,
      required this.videoThumbnail,
      required this.channelTitle,
      required this.channelThumbnail});

  final String videoId;
  final String videoTitle;
  final String videoThumbnail;
  final String channelTitle;
  final String channelThumbnail;

  @override
  State<QuizGenerationPage> createState() => _QuizGenerationPageState();
}

class _QuizGenerationPageState extends State<QuizGenerationPage>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  late bool dataReceived;
  Map<String, dynamic> data = {};
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _slideUpAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeInAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _slideUpAnimation =
        Tween<double>(begin: 30.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    // Simulate some async initialization
    Future.delayed(const Duration(seconds: 0), () async {
      data = await api.getQuiz(widget.videoId);

      if (data['status'] == 'true') {
        dataReceived = true;
        data = data['data'];
        setState(() {
          isLoading = false;
        });
        _animationController.forward();
      } else {
        dataReceived = false;
        setState(() {
          isLoading = false;
        });
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: isLoading
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your quiz is being generated, please wait...",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CircularProgressIndicator(),
                  ],
                )
              : dataReceived
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeTransition(
                          opacity: _fadeInAnimation,
                          child: const Text(
                            "The quiz has been generated",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 25),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0.0, _slideUpAnimation.value),
                              child: child,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Instructions for the quiz:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "1. There are a total of 10 questions in this quiz.",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                "2. Each question will be presented with four multiple-choice options labeled A, B, C, and D.",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                "3. Read each question and all options carefully before selecting your answer.",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                "4. To answer a question, simply choose the option (A, B, C, or D) that you believe is correct.",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                "5. Once you have selected an answer, proceed to the next question. You can go back to previous questions.",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                "6. Ensure you submit your answers within the allotted time frame. If no time frame is specified, aim to complete the quiz within a reasonable amount of time.",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                "7. At the end of the quiz, you will receive your score based on the number of correct answers",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                "8. The correct answer to each question will be revealed after you submit your answers.",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                "9. Remember, there is no penalty for guessing, so it's better to make an educated guess than to leave a question unanswered.",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                "10. Enjoy the quiz and good luck!",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Questions(
                                      data: data,
                                      videoId: widget.videoId,
                                      videoTitle: widget.videoTitle,
                                      videoThumbnail: widget.videoThumbnail,
                                      channelTitle: widget.channelTitle,
                                      channelThumbnail: widget.channelThumbnail,
                                    );
                                  }));
                                },
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.9,
                                height: 50,
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  "Begin Quiz",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.xmark,
                          color: Colors.red,
                          size: 40,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Sorry, the quiz couldn't be generated for the video",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minWidth: 200,
                          height: 50,
                          child: const Text(
                            "Go Back",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
        ),
      ),
    );
  }
}
