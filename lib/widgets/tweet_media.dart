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
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2), // changes position of shadow
              )
            ],
            borderRadius: borderRadius,
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: AspectRatio(
              aspectRatio: 1.69,
              child: Image.network(
                tweet.imageUrls[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }

    return Container();
  }
}
