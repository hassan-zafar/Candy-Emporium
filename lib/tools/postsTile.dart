import 'package:candy_emporium/adminScreens/postScreen.dart';
import 'package:candy_emporium/tools/customImages.dart';
import 'package:candy_emporium/tools/posts.dart';
import 'package:flutter/material.dart';


class PostTile extends StatelessWidget {
  final Post post;
  PostTile(this.post);

  showPost(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PostScreen(
                  userId: post.ownerId,
                  postId: post.postId,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPost(context),
      child: cachedNetworkImage(post.postMediaUrl),
    );
  }
}
