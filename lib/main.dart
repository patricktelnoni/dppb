import 'package:dppb/ScreenArguments.dart';
import 'package:flutter/material.dart';
import 'pagedua.dart';
import 'pagetiga.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'view/get_data_http.dart';
import 'auth/login_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const MyHomePage(title: "Contoh Layout"),
      initialRoute: '/',
      routes: {
        '/login' : (context) => LoginForm(),
        '/second': (context) => const SecondPage(),
        '/third': (context) =>const ThirdPage(),
        '/http':(context) => const GetDataHttp(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double rating = 3.5;
  int starCount = 5;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextButton(
               onPressed: (){
                //Navigator.pushNamed(context, '/second');
                 showModalBottomSheet<void>(
                     context: context,
                     builder: (BuildContext context) {
                       return Container(
                         height: 200,
                         color: Colors.amber,
                         child: Center(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               const Text('Beri rating pesanan anda'),
                               StarRating(
                                 size: 40.0,
                                 rating: rating,
                                 color: Colors.orange,
                                 borderColor: Colors.grey,
                                 allowHalfRating: true,
                                 starCount: 5,
                                 onRatingChanged: (rating) => setState(() {
                                   this.rating = rating;
                                 }),

                               ),
                               ElevatedButton(
                                 child: const Text('Close BottomSheet'),
                                 onPressed: () => Navigator.pop(context),
                               ),
                             ],
                           ),
                         ),
                       );
                     },
                     isDismissible: false);


               },
               child: Text("halaman 2")
           ),
            TextButton(
                onPressed: (){
                  Navigator.pushNamed(context,
                      '/third',
                  arguments: ScreenArguments('judul', 'Isi named route'));
                },
                child: Text("halaman 3")
            ),
            TextButton(
                onPressed: (){
                  Navigator.pushNamed(context,
                      '/http');
                },
                child: Text("Halaman http")
            ),
            TextButton(
                onPressed: (){
                  Navigator.pushNamed(context,
                      '/login');
                },
                child: Text("Halaman login")
            ),
          ],
        ),


    );
  }
}
