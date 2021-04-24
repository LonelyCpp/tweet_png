import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweet_png/api/tweet.dart';
import 'package:tweet_png/api/twitter_api.dart';
import 'package:tweet_png/state/app_state.dart';

void showTweetInputSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => TweetInputSheet(),
  );
}

class TweetInputSheet extends StatefulWidget {
  @override
  _TweetInputSheetState createState() => _TweetInputSheetState();
}

class _TweetInputSheetState extends State<TweetInputSheet> {
  final tweetLinkController = TextEditingController(
      text: 'https://twitter.com/goodreads/status/1385695224056406023');
  final tweetTokenController = TextEditingController();

  SharedPreferences prefInstance;
  String tweetKey;
  String linkError, keyError;

  initState() {
    super.initState();
    SharedPreferences.getInstance().then((instance) {
      prefInstance = instance;
      String key = instance.getString('TWEET_KEY');
      setState(() {
        tweetKey = key;
        tweetTokenController.text = key;
      });
    });
  }

  onPressOk(BuildContext context) async {
    String tweetLink = tweetLinkController.text;
    String _tweetKey = tweetTokenController.text;

    setState(() {
      keyError = null;
      keyError = null;
    });

    TwitterApi t = TwitterApi(_tweetKey);
    try {
      String id = Uri.parse(tweetLink).pathSegments.last;
      Tweet tweet = await t.getTweet(id);
      Provider.of<AppState>(context, listen: false).setTweetData = tweet;
      prefInstance.setString('TWEET_KEY', _tweetKey);
      Navigator.of(context).pop();
    } catch (error) {
      print(error);
      if (error == 401) {
        print(tweetKey);
        setState(() => keyError = 'invalid key');
      } else {
        setState(() => linkError = 'invalid link');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: tweetLinkController,
            decoration: InputDecoration(
              hintText: 'Enter tweet link',
              errorText: linkError,
            ),
          ),
          SizedBox(height: 24),
          TextField(
            controller: tweetTokenController,
            decoration: InputDecoration(
              hintText: 'twitter token',
              errorText: keyError,
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => onPressOk(context),
            child: Text('OK'),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 24),
        ],
      ),
    );
  }
}
