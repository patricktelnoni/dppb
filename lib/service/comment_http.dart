import 'package:http/http.dart' as http;
import 'package:dppb/data/PostComments.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<int> postComment(int postId, String comment) async{
  final url  = Uri.parse("https://palugada.me/api/comments");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({"title": comment, "content":comment, "user_id":1, "post_id": postId}),
  );
  return response.statusCode;

}

Future<List<PostComment>> getCommentList(int postId) async {
  final token = await storage.read(key: 'access_token');
  final List<PostComment> comments = [];
  final url  = "https://palugada.me/api/posts/$postId/comments/";
  final response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Accept': 'application/json;',
      //'Authorization': 'Bearer $token', // Include the token in the header
    },
  );
  print(response.body);
  if(response.statusCode == 200 || response.statusCode == 201){
    final list = jsonDecode(response.body);
    for(var data in list['data']){
      comments.add(PostComment.fromJson(data));
    }
  }
  print(comments.length);
  return comments;
}