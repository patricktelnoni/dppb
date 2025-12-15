import 'package:dppb/data/Content.dart';
import 'package:flutter/material.dart';
import 'package:dppb/service/post_http.dart';


class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<Content> posts = [];

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
                    color: Colors.pinkAccent,
                    child:  LayoutBuilder(
                        builder: (context, constraints){
                          return Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(8.0),
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
                                                backgroundColor: Colors.grey, // Button background color
                                                foregroundColor: Colors.white, // Text/icon color
                                                shadowColor: Colors.lightBlue, // Shadow color
                                                elevation: 10, // Button elevation
                                              ),
                                            ),
                                            ElevatedButton(
                                                onPressed: (){
                                                  print("Nunggu komen");
                                                },
                                                child: Icon(
                                                  Icons.comment,
                                                  color: Colors.amberAccent,
                                                ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey, // Button background color
                                                foregroundColor: Colors.white, // Text/icon color
                                                shadowColor: Colors.lightBlue, // Shadow color
                                                elevation: 10, // Button elevation
                                              ),
                                            )

                                          ],
                                        )
                                      ],
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
