import 'package:flutter/material.dart';

void main() => runApp(FeedbackApp());

class FeedbackApp extends StatefulWidget {
  @override
  _FeedbackAppState createState() => _FeedbackAppState();
}

class _FeedbackAppState extends State<FeedbackApp> {
  int _questionIndex = 0; // to store the index of the questions list
  int _resultIndex = 0; // to store the index of the results list
  int _feedbackScore = 1; // to store the feedback score
  int _total = 0; // to store the overall score
  bool _isFeedbackCompleted =
      false; // to check is the feedback is completed or not

  final List<String> questions = [
    'How did you like our service?',
    'How did you appreciate the santiation?',
    'How was the sound quality?',
    'How was the lighting?',
    'How likely are you to recommend us to your friends?',
    'How likely are you to come back here?',
  ];

  final List<Widget> results = [
    Text(
      'We are sorry for your inconvenience.',
      style: TextStyle(
        color: Colors.red,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    ),
    Text(
      'Hope we serve you better next time.',
      style: TextStyle(
        color: Colors.yellow,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    ),
    Text(
      'We hope you come back next time.',
      style: TextStyle(
        color: Colors.green,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    ),
  ];

  void updateQuestion() {
    _total += _feedbackScore;
    setState(() {
      if (_questionIndex == 5) {
        _isFeedbackCompleted = true;
        _questionIndex = 0;

        // setting the _resultIndex according to the total score
        if (_total <= 10)
          _resultIndex = 0;
        else if (_total <= 20)
          _resultIndex = 1;
        else
          _resultIndex = 2;
      }
      // incrementing the _questionIndex to jump to the next question
      _questionIndex++;
      // reseting the _feedbackScore to 1 for the next question
      _feedbackScore = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Feedback App',
          ),
        ),
        body: Visibility(
          visible: !_isFeedbackCompleted,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${questions[_questionIndex]}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            '$_feedbackScore',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Slider(
                          value: _feedbackScore.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              _feedbackScore = value.round();
                            });
                          },
                          min: 1,
                          max: 5,
                          divisions: 4,

                          // changing the active color according to the _feedbackScore
                          activeColor: _feedbackScore <= 3
                              ? Colors.yellow
                              : _feedbackScore == 4
                                  ? Colors.orangeAccent
                                  : Colors.orange,

                          // changing the inactive color according to the _feedbackScore
                          inactiveColor: _feedbackScore <= 2
                              ? Colors.black
                              : _feedbackScore == 3
                                  ? Colors.purple
                                  : Colors.purpleAccent,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: updateQuestion,
                    child: Text(
                      'Next',
                    ),
                  ),
                ],
              ),
            ),
          ),
          replacement: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: results[_resultIndex],
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      // reseting _isFeedbackCompleted, _resultIndex, _total with initial values
                      _isFeedbackCompleted = false;
                      _resultIndex = 0;
                      _total = 0;
                    });
                  },
                  child: Text('Reset'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
