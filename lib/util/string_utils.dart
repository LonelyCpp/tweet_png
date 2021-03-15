import 'package:flutter/material.dart';

class _RichTweetSpan {
  final String text;
  final bool isHighlighted;

  _RichTweetSpan(this.text, this.isHighlighted);
}

List<_RichTweetSpan> tweetToRichText(String tweet) {
  return tweet.split(' ').map((e) {
    return _RichTweetSpan(e, e.startsWith(RegExp(r'[#@]|https://')));
  }).toList();
}
