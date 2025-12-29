import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dppb/viewmodel/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account")),
      body: Consumer<AuthViewModel>(
        builder: (context, authVm, child) {
          if (authVm.getLoggedIn) {
            // Display Account Settings if logged in
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   UserAccountsDrawerHeader(
                       accountName: Text(authVm.getUser?.name ?? "User"),
                       accountEmail: Text("User ID: ${authVm.getUser?.userId ?? ''}"),
                       currentAccountPicture: CircleAvatar(
                         backgroundColor: Colors.white,
                         child: Text(
                           authVm.getUser?.name?.isNotEmpty == true
                               ? authVm.getUser!.name![0].toUpperCase()
                               : "U",
                           style: const TextStyle(fontSize: 24.0, color: Colors.blueAccent),
                         ),
                       ),
                       decoration: const BoxDecoration(color: Colors.blueAccent),
                     ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await authVm.logout();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Logged out successfully')),
                        );
                      }
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                  ),
                ],
              ),
            );
          } else {
            // Display Login Form if not logged in
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: email,
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Enter your password",
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      bool authenticated = await authVm.login(email.text, password.text);
                      if (authenticated && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login success!')),
                        );
                      } else if (!authenticated && context.mounted) {
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login failed!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Login"),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
