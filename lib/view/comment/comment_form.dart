import 'package:flutter/material.dart';
import 'package:dppb/transition/item_transition.dart';
import 'package:dppb/service/comment_http.dart';

class CommentForm extends StatefulWidget {
  final int? postId;

  const CommentForm({super.key, required this.postId});

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comment")),
      body: ItemTransition(
          content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _notesController,
                  minLines: 10, // Sets the minimum height to 4 lines
                  maxLines: null, // Allows the field to expand indefinitely
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    //labelText: 'Enter your notes or details',
                    hintText: 'Type comment here...',
                    alignLabelWithHint: true, // Aligns label to the top for multiline fields
                    border: OutlineInputBorder( // Provides the "textarea" border look
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async{
                      int statusCode = await postComment(widget.postId!, _notesController.text);
                      if(statusCode == 200 || statusCode == 201)
                        {
                          Navigator.pop(context);
                        }
                      else{
                       var snackBar = SnackBar(
                         content: Text("Gagal"),
                       );
                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text("Send")
                )
              ]
          )
      ),
    );
  }
}
