import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tweet_png/api/tweet.dart';
import 'package:tweet_png/state/app_state.dart';

var _dateFormatter = new DateFormat('h:mm a · MMM d, yyyy');
const double _statFontSize = 16;

class TweetDataWidget extends StatelessWidget {
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 23,
                  backgroundImage: NetworkImage(tweet.authorProfilePicUrl),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              tweet.text,
              style: TextStyle(
                height: 1.2,
                fontSize: 18,
                color: theme.textTheme.bodyText1.color,
              ),
            ),
          ),
          Visibility(
            visible: appState.showDate,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                // "8:07 AM · Feb 24, 2021",
                _dateFormatter.format(tweet.createdAt),
                style: TextStyle(color: theme.disabledColor, fontSize: 12),
              ),
            ),
          ),
          Visibility(
            visible: appState.showStats,
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: appState.showLikes,
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          size: _statFontSize,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(NumberFormat.compact().format(tweet.likes),
                            style: TextStyle(
                              fontSize: _statFontSize,
                              color: theme.textTheme.caption.color,
                            )),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: appState.showRetweets,
                    child: Row(
                      children: [
                        Icon(
                          Icons.repeat_rounded,
                          size: _statFontSize,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(NumberFormat.compact().format(tweet.retweets),
                            style: TextStyle(
                              fontSize: _statFontSize,
                              color: theme.textTheme.caption.color,
                            )),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: appState.showReplies,
                    child: Row(
                      children: [
                        Icon(
                          Icons.mode_comment_outlined,
                          size: _statFontSize,
                          color: theme.textTheme.caption.color,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(NumberFormat.compact().format(tweet.replies),
                            style: TextStyle(
                              fontSize: _statFontSize,
                              color: theme.textTheme.caption.color,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
