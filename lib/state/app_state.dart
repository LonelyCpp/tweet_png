import '../api/tweet.dart';
import 'package:flutter/material.dart';
import 'package:tweet_png/widgets/layouts/tweet_layout_picker.dart';

class AppState extends ChangeNotifier {
  Tweet _tweet;

  bool darkMode = false;

  bool showDate = true;
  bool showLikes = true;
  bool showStats = true;
  bool showReplies = true;
  bool showRetweets = true;

  Color bgColor = Colors.lightBlue;

  TweetLayoutName layout = TweetLayoutName.DEFAULT;

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

  void toggleDarkMode() {
    darkMode = !darkMode;
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

  void toggleLikes() {
    showLikes = !showLikes;
    notifyListeners();
  }

  void toggleRetweets() {
    showRetweets = !showRetweets;
    notifyListeners();
  }

  void toggleReplies() {
    showReplies = !showReplies;
    notifyListeners();
  }

  set setLayout(TweetLayoutName newLayout) {
    layout = newLayout;
    notifyListeners();
  }
}
