import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dppb/data/User.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier{
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  final storage = FlutterSecureStorage();


  Future<void> isUserLoggedIn() async{
    String? _token = await storage.read(key: 'access_token');
    if(_token != null){
      _isLoggedIn = true;
    }
    notifyListeners();
  }

  Future<String> login(String email, String password) async{

    final url = Uri.parse("https://palugada.me/api/login");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email, "password": password}),
    );
    print(response.statusCode);
    if(response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 302){
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data['access_token']);
      await storage.write(key: 'access_token', value: data['access_token']);
      _isLoggedIn = true;
      notifyListeners();
    }
    return response.body;
  }
}
