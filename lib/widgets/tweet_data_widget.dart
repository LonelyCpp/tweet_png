import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tweet_png/api/tweet.dart';
import 'package:tweet_png/state/app_state.dart';

var dateFormatter = new DateFormat('h:mm a · MMM d, yyyy');

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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    '@${tweet.authorTwitterHandle}',
                    style: TextStyle(color: Colors.black45, fontSize: 15),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              tweet.text,
              style: TextStyle(fontSize: 18, height: 1.2),
            ),
          ),
          Visibility(
            visible: appState.showDate,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                // "8:07 AM · Feb 24, 2021",
                dateFormatter.format(tweet.createdAt),
                style: TextStyle(color: Colors.black45, fontSize: 12),
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
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_rounded,
                        size: 18,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(tweet.likes.toString(),
                          style:
                              TextStyle(color: Colors.black45, fontSize: 18)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.repeat_rounded,
                          size: 18, color: Colors.black45),
                      SizedBox(
                        width: 4,
                      ),
                      Text(tweet.retweets.toString(),
                          style:
                              TextStyle(color: Colors.black45, fontSize: 18)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.mode_comment_outlined,
                          size: 18, color: Colors.black45),
                      SizedBox(
                        width: 4,
                      ),
                      Text(tweet.replies.toString(),
                          style:
                              TextStyle(color: Colors.black45, fontSize: 18)),
                    ],
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
