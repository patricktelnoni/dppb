import 'package:dppb/data/PostComments.dart';
import 'package:flutter/material.dart';
import 'package:dppb/service/comment_http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class CommentViewModel extends ChangeNotifier {
  final storage = FlutterSecureStorage();

  List<PostComment> comments = [];

  Future<void> postComment() async {

  }



  Future<List<PostComment>> fetchComments(int postId) async {
    final response = await getCommentList(postId);
    if(response.statusCode == 200 || response.statusCode == 201){
      final list = jsonDecode(response.body);
      if (list['data'] != null) {
        for(var data in list['data']){
          comments.add(PostComment.fromJson(data));
        }
      }
    }
    return comments;
  }
}