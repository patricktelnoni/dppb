
import 'package:dppb/data/User.dart';

class PostComment{
  final String? title;
  final String? content;
  final User? author;

  PostComment({required this.title, required this.content, required this.author});

  factory PostComment.fromJson(Map<String, dynamic> json) {
    return PostComment(
      title: json['title'],
      content: json['content'],
      author: User.fromJson(json['user']),
    );
  }
}