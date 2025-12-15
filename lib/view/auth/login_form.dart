import 'package:dppb/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dppb/service/auth_http.dart';
import 'package:provider/provider.dart';


class LoginForm extends StatelessWidget {

  LoginForm({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Form"),),
      body: Column(
        children: [
          TextField(
            controller: email,
            decoration: InputDecoration(
              hintText: "Enter your email",
              labelText: "Email",
            ),


          ),
          TextField(
            controller: password,
            decoration: InputDecoration(
              hintText: "Enter your password",
              labelText: "Password",

            ),
          ),
          ElevatedButton(
              onPressed: () async {
                var authService = context.read<AuthService>();
                if(await authService.login(email.text, password.text)){
                  Navigator.pushNamed(context, '/http');
                }
              },
              child: Text("Kirim")
          )
        ],
      ),
    );
  }
}
