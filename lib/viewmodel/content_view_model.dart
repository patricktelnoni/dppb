import 'package:flutter/material.dart';
import 'package:dppb/data/Content.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dppb/service/content_http.dart';
import 'dart:convert';

class ContentViewModel extends ChangeNotifier{
  final storage = FlutterSecureStorage();

  List<Content> contents = [];

  Future<void> postComment() async {

  }

  Future<List<Content>> fetchPosts() async {
    final response;
    final token = await storage.read(key: 'access_token');
    final userid = await storage.read(key: 'user_id');

    if(token != null && userid != null)
      response = await ContentService().getContentByUserId(int.parse(userid));

    else
      response = await ContentService().getContentList();


    if(response.statusCode == 200 || response.statusCode == 201){
      final list = jsonDecode(response.body);
      for(var data in list['data']){
        contents.add(Content.fromJson(data));
      }
    }
    return contents;
  }


}