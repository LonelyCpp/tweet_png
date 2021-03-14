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

    var profilePic = user['profile_image_url'].toString();

    // profile pic url is of the form <somelink>_normal.jpg
    // remove "_normal" in image url to get higher quality image
    var extenstion = profilePic.substring(profilePic.length - 4);
    profilePic = profilePic.substring(0, profilePic.length - 11) + extenstion;

    return Tweet(
      dt['text'],
      DateTime.parse(dt['created_at']),
      dt['public_metrics']['like_count'],
      dt['public_metrics']['reply_count'],
      dt['public_metrics']['retweet_count'],
      user['name'],
      user['username'],
      profilePic,
    );
  }
}
