import 'package:dppb/data/Content.dart';
import 'package:dppb/view/comment/comment_list.dart';
import 'package:flutter/material.dart';
import 'package:dppb/service/post_http.dart';
import 'package:dppb/transition/item_transition.dart';
import 'package:dppb/view/comment/comment_form.dart';


class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<Content> posts = [];
  late AnimationController animationController;
  late Animation<double> animation;
  bool _visible = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ambil data"),),
      body:FutureBuilder(
          future: getPostList(),
          builder: (context, snapshot){
            posts = snapshot.hasData ? snapshot.data! : [];
            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index){
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white70,
                    child:  LayoutBuilder(
                        builder: (context, constraints){
                          return Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () async => await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => CommentList(postId: posts[index].id))),
                                      child: Column(

                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${posts[index].title}",
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize:18
                                            ),
                                          ),
                                          Text(
                                            "${posts[index].body}",
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                onPressed: (){
                                                  print("Nunggu likenya kaka");
                                                },
                                                child: Icon(Icons.star, color: Colors.amberAccent),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.transparent, // Button background color
                                                  foregroundColor: Colors.transparent, // Text/icon color
                                                  shadowColor: Colors.transparent, // Shadow color
                                                  elevation: 10, // Button elevation
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: (){
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => CommentForm(postId: posts[index].id)));
                                                },
                                                child: Icon(
                                                  Icons.comment,
                                                  color: Colors.amberAccent,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.transparent, // Button background color
                                                  foregroundColor: Colors.transparent, // Text/icon color
                                                  shadowColor: Colors.transparent, // Shadow color
                                                  elevation: 10, // Button elevation
                                                ),
                                              )

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  )
                              )
                            ],
                          );
                        }
                    ),
                  );
                }
            );


          }),
    );
  }
}