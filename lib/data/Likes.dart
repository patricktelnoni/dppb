class Likes{
  final int? userId;
  final int? postId;

  Likes({this.userId, this.postId});

  factory Likes.fromJson(Map<String, dynamic> json) {
    return Likes(
      userId: json['user_id'],
      postId: json['post_id'],
    );
  }

}