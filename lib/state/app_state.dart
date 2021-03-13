import 'package:flutter/material.dart';
import 'package:tweet_png/api/tweet.dart';

class AppState extends ChangeNotifier {
  Tweet _tweet;
  bool showStats = true;
  bool showDate = true;
  Color bgColor = Colors.lightBlue;

  Tweet get getTweetData {
    return _tweet;
  }

  set setTweetData(Tweet tweet) {
    _tweet = tweet;
    notifyListeners();
  }

  set setBgColor(Color c) {
    bgColor = c;
    notifyListeners();
  }

  void toggleStats() {
    showStats = !showStats;
    notifyListeners();
  }

  void toggleDate() {
    showDate = !showDate;
    notifyListeners();
  }
}
