import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tweet_png/api/tweet.dart';

class TwitterApi {
  final String bearer;

  TwitterApi(this.bearer);

  Future<Tweet> getTweet(String id) async {
    const base = 'https://api.twitter.com/2/tweets';

    const expansions = 'expansions=author_id,attachments.media_keys';
    const userFields = 'user.fields=profile_image_url';
    const tweetFields = 'tweet.fields=created_at,public_metrics';
    const mediaFields = 'media.fields=height,width,type,url,preview_image_url';

    var res = await http.get(
      '$base?ids=$id&$expansions&$tweetFields&$userFields&$mediaFields',
      headers: {'Authorization': 'Bearer ${this.bearer}'},
    );

    print(res.body);

    if (res.statusCode == 200) {
      return Tweet.fromTwitterResponse(jsonDecode(res.body));
    }

    throw res.statusCode;
  }
}
