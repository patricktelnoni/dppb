import 'package:http/http.dart' as http;
import 'package:dppb/data/PostComments.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<int> postComment(int postId, String comment) async{
  final url  = Uri.parse("https://palugada.me/api/comments");
  final token = await storage.read(key: 'access_token');
  
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  if (token != null) {
    headers['Authorization'] = 'Bearer $token';
  }

  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode({"title": comment, "content":comment, "user_id":1, "post_id": postId}),
  );
  return response.statusCode;

}

Future<http.Response> getCommentList(int postId) async {
  final token = await storage.read(key: 'access_token');

  final url  = "https://palugada.me/api/content/$postId/comments"; // Removed trailing slash
  
  Map<String, String> headers = {
      'Accept': 'application/json',
  };
  
  if (token != null) {
    headers['Authorization'] = 'Bearer $token';
  }


    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    return response;


}
