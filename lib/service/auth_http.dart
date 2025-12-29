import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService{


  Future<void> logout() async{

  }

  Future<http.Response> login(String email, String password) async{
    print('loggginnn');
    final url = Uri.parse("https://palugada.me/api/login");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email, "password": password}),
    );

    return response;
  }
}
