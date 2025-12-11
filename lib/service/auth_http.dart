import 'package:http/http.dart' as http;
import 'package:dppb/data/User.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<String> login(String email, String password) async{
  final url = Uri.parse("https://palugada.me/api/login");
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: User(email: email, password: password).toJson(),
  );
  if(response.statusCode == 200 || response.statusCode == 201){
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data['access_token']);
    await storage.write(key: 'access_token', value: data['access_token']);
  }
  return response.body;
}