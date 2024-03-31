import 'package:flutter/material.dart';
import 'package:hackdu/pages/History/Components/quizHistory.dart';
import 'package:hackdu/pages/History/Components/watchHistory.dart';
import '../../database/database.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.uid});

  final String uid;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    HistoryDatabase historyDatabase = HistoryDatabase();
    QuizDatabase quizDatabase = QuizDatabase();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.5),
        ),
        bottom: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          indicatorColor: Colors.black,
          onTap: (index) {
            if (index == 0) {
              if (currentIndex != 0) {
                currentIndex = 0;
                setState(() {});
              }
            } else {
              if (currentIndex != 1) {
                currentIndex = 1;
                setState(() {});
              }
            }
          },
          controller: tabController,
          tabs: const [
            Tab(
              text: "Watch",
            ),
            Tab(
              text: "Quiz",
            )
          ],
        ),
      ),
      body: currentIndex == 0
          ? WatchHistory(
              historyDatabase: historyDatabase,
              uid: widget.uid,
            )
          : QuizHistory(uid: widget.uid, quizDatabase: quizDatabase),
    );
  }
}
