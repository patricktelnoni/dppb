import 'package:dppb/ScreenArguments.dart';
import 'package:flutter/material.dart';
import 'view/pagedua.dart';
import 'view/pagetiga.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'view/products/get_data_http.dart';
import 'package:dppb/view/auth/login_form.dart';
import 'package:provider/provider.dart';
import 'package:dppb/service/auth_http.dart';
import 'package:dppb/view/posts/post_list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => AuthService()..isUserLoggedIn(),
        child: const MyApp()
  )
  );
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
        '/posts':(context) => const PostList(),
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
      body:  Column(
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
            Consumer<AuthService>(
                builder: (context, auth, child){
                  if(auth.getLoggedIn){
                    return TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context,
                              '/http');
                        },
                        child: Text("Halaman http")
                    );
                  }
                  else{
                    return Text("Not accessible");

                  }
                }
            ),
            TextButton(
                onPressed: (){
                  Navigator.pushNamed(context,
                      '/login');
                },
                child: Text("Halaman login")
            ),
            TextButton(onPressed: (){
              Navigator.pushNamed(context,
                  '/posts');
            },
                child: Text("Halaman Post"))
          ],
        ),


    );
  }
}
