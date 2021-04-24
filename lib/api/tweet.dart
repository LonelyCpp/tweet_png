class Tweet {
  final String text;
  final DateTime createdAt;

  final int likes;
  final int replies;
  final int retweets;

  final bool verified;
  final String authorName;
  final String authorTwitterHandle;
  final String authorProfilePicUrl;

  final List<String> imageUrls;

  Tweet(
    this.text,
    this.createdAt,
    this.likes,
    this.replies,
    this.retweets,
    this.verified,
    this.authorName,
    this.authorTwitterHandle,
    this.authorProfilePicUrl,
    this.imageUrls,
  );

  static fromTwitterResponse(Map<String, dynamic> json) {
    final dt = json['data'][0];
    final user = json['includes']['users'][0];
    final List media = json['includes']['media'];

    final List<String> imageUrls = [];
    if (media != null) {
      media.forEach((element) {
        if (element['type'] == 'photo') {
          imageUrls.add(element['url'].toString());
        }
      });
    }

    // profile pic url is of the form <somelink>_normal.jpg
    // remove "_normal" in image url to get higher quality image
    var profilePic = user['profile_image_url'].toString();
    var extenstion = profilePic.substring(profilePic.length - 4);
    profilePic = profilePic.substring(0, profilePic.length - 11) + extenstion;

    return Tweet(
      dt['text'],
      DateTime.parse(dt['created_at']),
      dt['public_metrics']['like_count'],
      dt['public_metrics']['reply_count'],
      dt['public_metrics']['retweet_count'],
      user['verified'],
      user['name'],
      user['username'],
      profilePic,
      imageUrls,
    );
  }
}
