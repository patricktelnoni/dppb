import 'package:dppb/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dppb/service/auth_http.dart';
import 'package:go_router/go_router.dart';
import 'package:dppb/route/shell_route.dart'; // Import the router configuration

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => AuthViewModel(),
        child: const MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router, // Use the router from shell_route.dart
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,  required  this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double rating = 3.5;
  int starCount = 5;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Halaman utama"),
      ),
      body:  widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
              currentIndex: widget.navigationShell.currentIndex,
              onTap: _goBranch,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.timeline), label: 'Post',),
                BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Account',)
              ]
          ),
    );
  }
}
