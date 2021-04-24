import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tweet_png/api/tweet.dart';
import 'package:tweet_png/state/app_state.dart';
import 'package:tweet_png/util/string_utils.dart';
import 'package:tweet_png/widgets/layouts/tweet_layout_base.dart';
import 'package:tweet_png/widgets/tweet_media.dart';

var _dateFormatter = new DateFormat('h:mm a · MMM d, yyyy');

class TweetLayoutQuote extends TweetLayoutBase {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      Tweet tweet = appState.getTweetData;
      ThemeData theme = Theme.of(context);

      if (tweet == null) {
        return Text('no tweet');
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.format_quote_rounded,
            size: 32,
            color: theme.textTheme.caption.color,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  height: 1.5,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: theme.textTheme.bodyText1.color,
                ),
                children: tweetToRichText(tweet.text)
                    .map((e) => TextSpan(
                        text: '${e.text} ',
                        style: e.isHighlighted
                            ? TextStyle(color: theme.accentColor)
                            : null,
                        children: []))
                    .toList(),
              ),
            ),
          ),
          TweetMedia(tweet: tweet),
          Container(height: 32),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(tweet.authorProfilePicUrl),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        tweet.authorName,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyText1.color,
                        ),
                      ),
                      Visibility(
                        visible: tweet.verified,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Image.asset(
                            'assets/verified.png',
                            width: 18,
                            height: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    '@${tweet.authorTwitterHandle}',
                    style: TextStyle(
                      fontSize: 15,
                      color: theme.textTheme.caption.color,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      );
    });
  }
}
