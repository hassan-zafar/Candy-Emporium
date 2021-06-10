import 'package:candy_emporium/config/collections.dart';
import 'package:candy_emporium/tools/posts.dart';
import 'package:candy_emporium/tools/progress.dart';
import 'package:flutter/material.dart';


class PostScreen extends StatelessWidget {
  final String userId;
  final String postId;
  PostScreen({
    this.userId,
    this.postId,
  });
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: postsRef.doc(userId).collection('adminPosts').doc(postId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return bouncingGridProgress();
          }
          Post post = Post.fromDocument(snapshot.data);
          return Center(
            child: Scaffold(
              appBar: AppBar(
                title: Text(post.postTitle),
              ),
              body: ListView(
                children: <Widget>[
                  Container(
                    child: post,
                  )
                ],
              ),
            ),
          );
        });
  }
}
