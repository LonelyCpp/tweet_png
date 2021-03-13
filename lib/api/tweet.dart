class Tweet {
  final String text;
  final DateTime createdAt;

  final int likes;
  final int replies;
  final int retweets;

  final String authorName;
  final String authorTwitterHandle;
  final String authorProfilePicUrl;

  Tweet(
    this.text,
    this.createdAt,
    this.likes,
    this.replies,
    this.retweets,
    this.authorName,
    this.authorTwitterHandle,
    this.authorProfilePicUrl,
  );

  static fromTwitterResponse(Map<String, dynamic> json) {
    // print(json.toString());

    final dt = json['data'][0];
    final user = json['includes']['users'][0];

    return Tweet(
      dt['text'],
      DateTime.parse(dt['created_at']),
      dt['public_metrics']['like_count'],
      dt['public_metrics']['reply_count'],
      dt['public_metrics']['retweet_count'],
      user['name'],
      user['username'],
      user['profile_image_url'],
    );
  }
}
