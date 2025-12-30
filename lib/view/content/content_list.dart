import 'package:dppb/data/Content.dart';
import 'package:dppb/view/comment/comment_list.dart';
import 'package:dppb/viewmodel/auth_view_model.dart';
import 'package:dppb/widget/star_button.dart';
import 'package:flutter/material.dart';
import 'package:dppb/viewmodel/content_view_model.dart';
import 'package:dppb/service/likes_http.dart';
import 'package:dppb/transition/item_transition.dart';
import 'package:dppb/view/comment/comment_form.dart';
import 'package:provider/provider.dart';


class ContentList extends StatefulWidget {
  const ContentList({super.key});

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  List<Content> posts = [];
  late AnimationController animationController;
  late Animation<double> animation;
  bool _visible = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Lighter background for the screen
      appBar: AppBar(title: const Text("Ambil data"),),
      body: Consumer<AuthViewModel>(
          builder: (context, authVm, child) {
            return FutureBuilder(
                future: ContentViewModel().fetchPosts(),
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
                                                    if(authVm.getLoggedIn)
                                                      StarButton(
                                                        onPressed: () async {
                                                          final int statusCode = await hitLike(posts[index].id!);
                                                          if (context.mounted) {
                                                            if (statusCode == 200 || statusCode == 201) {
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                const SnackBar(content: Text('Like success!')),
                                                              );
                                                              return true;
                                                            } else {
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(content: Text('Failed to like post: $statusCode')),
                                                              );
                                                              return false;
                                                            }
                                                          }
                                                          return false;
                                                        },
                                                      ),

                                                    if(authVm.getLoggedIn)
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


                });
          }
      ),
    );
  }
}
