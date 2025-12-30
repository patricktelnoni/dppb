import 'package:flutter/material.dart';
import 'package:dppb/data/User.dart';
import 'package:dppb/service/auth_http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class AuthViewModel extends ChangeNotifier{
  final storage = FlutterSecureStorage();

  bool _isLoggedIn      = false;
  bool get getLoggedIn  => _isLoggedIn;

  User? _user;
  User? get getUser     => _user;

  Future<bool> login(String email, String password) async{
    
    final response = await AuthService().login(email, password);
    if(response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 302){
      Map<String, dynamic> data = jsonDecode(response.body);

      await storage.write(key: 'access_token', value: data['access_token']);
      await storage.write(key: 'user_id', value: data['user_id'].toString());
      await storage.write(key: 'username', value: data['username']);

      _isLoggedIn = true;
      _user = User(userId: data['user_id'], name: data['username']);
      notifyListeners();
    }
    
    return _isLoggedIn;
  }

  Future<void> getUserData() async{

    notifyListeners();
  }

  Future<void> logout() async{
    final response = await AuthService().logout();
    if(response.statusCode == 200){
      await storage.deleteAll();
      _isLoggedIn = false;
      _user = null;
      notifyListeners();
    }
  }

  Future<void> isUserLoggedIn() async{
    String? _token = await storage.read(key: 'access_token');
    if(_token != null){
      String? userIdStr = await storage.read(key: 'user_id');
      String? username = await storage.read(key: 'username');
      int? userId = userIdStr != null ? int.tryParse(userIdStr) : null;
      
      _isLoggedIn = true;
      if (userId != null && username != null) {
          _user = User(userId: userId, name: username);
      }
    } else {
      _isLoggedIn = false;
      _user = null;
    }
    notifyListeners();
  }

}