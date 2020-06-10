import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'question_bank.dart';

QuestionBank _questionBank = QuestionBank();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Quizz App',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black12,
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: quizz(),
          ),
        ),
      ),
    );
  }
}

class quizz extends StatefulWidget {
  @override
  _quizzState createState() => _quizzState();
}

class _quizzState extends State<quizz> {
  List<Icon> scorekeeper = [];
  int count = 0;
  int result;
  void checkans(bool user_picked) {
    bool crrct_ans = _questionBank.get_question_ans();

    setState(() {
      if (_questionBank.isFinished() == true) {
        Alert(
            context: context,
            //type: AlertType.success,
            title: 'Finished!',
            desc: 'Your Score:$result',
            image: Image.asset('images/success.png'),
            buttons: [
              DialogButton(

                child: Text('END', style: TextStyle(color: Colors.white)),
                onPressed: () => Navigator.pop(context),
                width: 150,
                color: Colors.redAccent,
                radius: BorderRadius.circular(10.0),
              ),
            ]).show();
        _questionBank.reset();
        _questionBank.re_count();
        scorekeeper = [];
      } else {
        if (crrct_ans == user_picked) {
          result = _questionBank.count();
          scorekeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scorekeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
      }

      _questionBank.check();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                _questionBank.get_questiontext(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green,
              onPressed: () {
                checkans(true);
              },
              child: Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              child: Text(
                'False',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
              color: Colors.red,
              onPressed: () {
                checkans(false);
              },
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        ),
      ],
    );
  }
}
