import 'package:flutter/material.dart';
import 'package:dppb/ScreenArguments.dart';

class ThirdPage extends StatelessWidget{
  const ThirdPage({super.key});

  static const routeName = '/third';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman tiga'),
      ),
    body: Column(
      children: [
        Text('${args.message}'),
        TextButton(
            onPressed: (){
              Navigator.pop(context);

            },
            child: Text("Kembali")
        )
      ],
    ),
    );
  }


}