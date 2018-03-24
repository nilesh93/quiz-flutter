import 'package:flutter/material.dart';
import 'package:quiz/UI/answer-button.dart';
import 'package:quiz/UI/question-text.dart';
import 'package:quiz/UI/result-overlay.dart';
import 'package:quiz/pages/score-page.dart';
import 'package:quiz/utils/question.dart';
import 'package:quiz/utils/quiz.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Flutter is Awesome", true),
    new Question("React Native is Awesome", false),
    new Question("Earth is Flat", true),
    new Question("Chuck Norris is mortal", false)
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect); // simply add score
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          // this is our main page
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false))
          ],
        ),
        overlayShouldBeVisible == true
            ? new ResultOverlay(isCorrect, () {
                if (quiz.length == questionNumber) {
                  Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new ScorePage(quiz.score, quiz.length)),(Route route) => route == null); // remove all previous pages
                  return;
                } else {
                  currentQuestion = quiz.nextQuestion;
                  this.setState(() {
                    overlayShouldBeVisible = false;
                    questionText = currentQuestion.question;
                    questionNumber = quiz.questionNumber;
                  });
                }
              })
            : new Container() // empty container will show nothing
      ],
    );
  }
}
