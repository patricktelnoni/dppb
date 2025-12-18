import 'package:dppb/data/Content.dart';
import 'package:dppb/view/comment/comment_list.dart';
import 'package:dppb/widget/star_button.dart';
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
      backgroundColor: Colors.grey[100], // Lighter background for the screen
      appBar: AppBar(title: const Text("Ambil data"),),
      body:FutureBuilder(
          future: getPostList(),
          builder: (context, snapshot){
            posts = snapshot.hasData ? snapshot.data! : [];
            return ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 20),
                itemCount: posts.length,
                itemBuilder: (context, index){
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    elevation: 2,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.lightBlue.shade50, // Bright, appealing color
                    child:  LayoutBuilder(
                        builder: (context, constraints){
                          return Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(16.0),
                                    child: GestureDetector(
                                      onTap: () async => await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => CommentList(postId: posts[index].id))),
                                      child: Column(

                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${posts[index].title}",
                                            overflow: TextOverflow.fade,
                                            style: const TextStyle(
                                                color: Colors.black87, // Dark text for readability
                                                fontWeight: FontWeight.w800,
                                                fontSize:18,
                                                letterSpacing: -0.5
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "${posts[index].body}",
                                            overflow: TextOverflow.fade,
                                            style: const TextStyle(
                                              color: Colors.black54, // Softer dark text
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              height: 1.4
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              const StarButton(),
                                              ElevatedButton(
                                                onPressed: (){
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => CommentForm(postId: posts[index].id)));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white, // White button background
                                                  foregroundColor: Colors.indigoAccent, // Harmonious color
                                                  shadowColor: Colors.black12,
                                                  elevation: 2, 
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                                ),
                                                child: const Icon(
                                                  Icons.comment_outlined,
                                                  color: Colors.indigoAccent,
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
