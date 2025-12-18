import 'package:http/http.dart' as http;
import 'package:dppb/data/Likes.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<int> unLike(int likeId) async{
  final url  = "https://palugada.me/api/likes/$likeId";
  final response = await http.delete(
    Uri.parse(url),
    headers: <String, String>{
      'Accept': 'application/json;',
      //'Authorization': 'Bearer $token', // Include the token in the header
    },
  );
  return response.statusCode;
}

Future<int> hitLike(int postId) async {
  final url  = "https://palugada.me/api/likes";
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json',
      //'Authorization': 'Bearer $token', // Include the token in the header
    },
    body: jsonEncode({"post_id": postId}),
  );
  print(response.body);
  return response.statusCode;
}