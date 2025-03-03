import 'dart:async';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      "question": "What is Flutter?",
      "options": ["Programming Language", "Framework", "Database", "Browser"],
      "answer": 1
    },
    {
      "question": "Who developed Flutter?",
      "options": ["Google", "Facebook", "Microsoft", "Apple"],
      "answer": 0
    },
    {
      "question": "Which language is used in Flutter?",
      "options": ["Java", "Python", "Dart", "C++"],
      "answer": 2
    }
  ];

  int _currentIndex = 0;
  int _score = 0;
  int _timeLeft = 10;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _timeLeft = 10;
      });
    } else {
      _timer.cancel();
      _showResult();
    }
  }

  void _checkAnswer(int index) {
    if (index == _questions[_currentIndex]["answer"]) {
      _score++;
    }
    _nextQuestion();
  }

  void _showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Quiz Completed"),
        content: Text("Your score is $_score out of ${_questions.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _score = 0;
                _timeLeft = 10;
                _startTimer();
              });
            },
            child: const Text("Retry"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Exit"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz App")),
      body: Center( // Centers the entire content
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Aligns content in center
            children: [
              Text(
                _questions[_currentIndex]["question"],
                textAlign: TextAlign.center, // Centers text
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ...List.generate(
                _questions[_currentIndex]["options"].length,
                    (index) => SizedBox(
                  width: double.infinity, // Makes buttons stretch to full width
                  child: ElevatedButton(
                    onPressed: () => _checkAnswer(index),
                    child: Text(
                      _questions[_currentIndex]["options"][index],
                      textAlign: TextAlign.center, // Centers text inside button
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Time left: $_timeLeft sec",
                textAlign: TextAlign.center, // Centers text
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
