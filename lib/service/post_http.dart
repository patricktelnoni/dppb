import 'package:http/http.dart' as http;
import 'package:dppb/data/Content.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<List<Content>> getPostList() async {
  final token = await storage.read(key: 'access_token');
  final List<Content> posts = [];
  final url  = "https://palugada.me/api/posts";
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
      posts.add(Content.fromJson(data));
    }
  }
  print(posts.length);
  return posts;
}