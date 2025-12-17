import 'package:dppb/data/PostComments.dart';
import 'package:dppb/data/User.dart';
import 'package:dppb/service/comment_http.dart';
import 'package:flutter/material.dart';

class CommentList extends StatefulWidget {
  final int? postId;

  const CommentList({super.key, required this.postId});

  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  List<PostComment> comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PostComment>>(
          future: getCommentList(widget.postId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              comments = snapshot.data!;
              if (comments.isEmpty) {
                return const Center(child: Text('No comments yet.'));
              }
              return ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.title ?? 'Anonymous',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(comment.content ?? ''),
                          const SizedBox(height: 8.0),
                          Text(comment.author?.name.toString() ?? ''),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No comments found.'));
            }
          }),
    );
  }
}
