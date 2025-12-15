import 'package:flutter/material.dart';
import 'package:dppb/ScreenArguments.dart';

class SecondPage extends StatefulWidget{
  const SecondPage({super.key});

  @override
  State<SecondPage> createState () => SecondPageState();
}

class SecondPageState extends State<SecondPage>{

  String data ="";
  TextEditingController dataController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman dua'),
      ),
        body:
            
          Column(
          children: [
            Text("$data"),
            TextField(
              controller: dataController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
            TextButton(
                onPressed: (){
                  setState(() {
                    data = dataController.text;
                    Navigator.pushNamed(context,
                        '/third',
                        arguments: ScreenArguments(
                            'judul',
                            dataController.text)

                    );
                  });
                },
                child: Text("Ubah")
            )
          ],
        ),
    );
  }
 }
