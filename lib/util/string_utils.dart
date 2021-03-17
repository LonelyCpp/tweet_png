import 'package:html_unescape/html_unescape.dart';

class _RichTweetSpan {
  final String text;
  final bool isHighlighted;

  _RichTweetSpan(this.text, this.isHighlighted);
}

final _unescaper = new HtmlUnescape();

List<_RichTweetSpan> tweetToRichText(String tweet) {
  var unescaped = _unescaper.convert(tweet);

  print(unescaped);

  return unescaped.split(' ').map((e) {
    return _RichTweetSpan(e, e.startsWith(RegExp(r'[#@]|https://')));
  }).toList();
}
