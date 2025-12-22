
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dppb/service/auth_http.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {

  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();

    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

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
                  SnackBar snackBar = SnackBar(
                    content: Text("Login berhasil"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pushNamed(context, '/products');
                }
              },
              child: Text("Kirim")
          )
        ],
      ),
    );
  }
}
