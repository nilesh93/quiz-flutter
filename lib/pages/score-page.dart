import 'package:flutter/material.dart';
import 'package:quiz/pages/landing-page.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ScorePage(this.score, this.totalQuestions);
  @override
  Widget build(BuildContext context) {
    return new Material(
        color: Colors.blueAccent,
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("Your Score",
                  style: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0)),
              new Text(score.toString() + "/" + totalQuestions.toString(),
                  style: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 70.0)),
              new Padding(
                padding: new EdgeInsets.symmetric(vertical: 20.0),
              ),
              new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: new IconButton(
                    icon: new Icon(Icons.arrow_right),
                    color: Colors.blueAccent,
                    iconSize: 50.0,
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new LandingPage()),
                          (Route route) =>
                              route == null); // remove all previous pages
                    },
                  )),
            ]));
  }
}
