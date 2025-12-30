import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService{

  final storage = FlutterSecureStorage();

  Future<http.Response> logout() async{
    final url = Uri.parse("https://palugada.me/api/logout");
    final token = await storage.read(key: 'access_token');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the token in the header
    });
    print(response.statusCode);
    return response;
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
    print(response.body);
    return response;
  }
}
