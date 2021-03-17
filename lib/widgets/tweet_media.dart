import 'package:flutter/material.dart';
import 'package:tweet_png/api/tweet.dart';

class TweetMedia extends StatelessWidget {
  final Tweet tweet;

  final borderRadius = BorderRadius.all(Radius.circular(8));

  TweetMedia({Key key, this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    if (tweet.imageUrls.length > 0) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(
                color: theme.disabledColor.withOpacity(0.2), width: 0.5),
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Image.network(
              tweet.imageUrls[0],
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return Container();
  }
}
