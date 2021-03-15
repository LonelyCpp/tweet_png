import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tweet_png/api/tweet.dart';
import 'package:tweet_png/state/app_state.dart';
import 'package:tweet_png/util/string_utils.dart';

var _dateFormatter = new DateFormat('h:mm a · MMM d, yyyy');
const double _statFontSize = 16;

class _TweetStat extends StatelessWidget {
  final int value;
  final Color color;
  final bool visible;
  final IconData icon;

  const _TweetStat({Key key, this.icon, this.value, this.visible, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    if (!visible) {
      return Container();
    }

    return Flexible(
      flex: 1,
      child: Row(
        children: [
          Icon(
            icon,
            size: _statFontSize,
            color: color,
          ),
          SizedBox(
            width: 4,
          ),
          Text(NumberFormat.compact().format(value),
              style: TextStyle(
                fontSize: _statFontSize,
                color: theme.textTheme.caption.color,
              )),
        ],
      ),
    );
  }
}

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
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  height: 1.2,
                  fontSize: 18,
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
                children: [
                  _TweetStat(
                    value: tweet.likes,
                    visible: appState.showLikes,
                    icon: Icons.favorite_rounded,
                    color: Colors.red,
                  ),
                  _TweetStat(
                    value: tweet.retweets,
                    visible: appState.showRetweets,
                    icon: Icons.repeat_rounded,
                    color: Colors.green,
                  ),
                  _TweetStat(
                    value: tweet.replies,
                    visible: appState.showReplies,
                    icon: Icons.mode_comment_outlined,
                    color: theme.textTheme.caption.color,
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
