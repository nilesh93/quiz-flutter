import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {
  final String _question;
  final int _questionNumber;

  QuestionText(this._question, this._questionNumber) {}
  @override
  State createState() => new QuestionTextState();
}

// need SingleTickerProviderStateMixin for animation
class QuestionTextState extends State<QuestionText>
    with SingleTickerProviderStateMixin {
  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fontSizeAnimationController = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);
    _fontSizeAnimation = new CurvedAnimation(
        parent: _fontSizeAnimationController, curve: Curves.bounceOut);
    _fontSizeAnimation.addListener(() => this.setState(
        () {})); // font size animation val changes, text needs to be re rendered
    _fontSizeAnimationController.forward(); // use the animation
  }

  @override
  void dispose() {
    _fontSizeAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
        color: Colors.white,
        child: new Padding(
            padding: new EdgeInsets.symmetric(vertical: 20.0),
            child: new Center(
              child: new Text(
                "Question " +
                    widget._questionNumber.toString() +
                    ": " +
                    widget._question,
                style: new TextStyle(
                    fontSize: _fontSizeAnimation.value *
                        15), // font size would be 0.1 ... 1.0, so if you want 15, multiply by 15
              ),
            )));
  }
}
