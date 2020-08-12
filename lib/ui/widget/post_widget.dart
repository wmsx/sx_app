import 'package:flutter/material.dart';
import 'package:sx_app/model/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget(
    this.post, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(post.title),
    );
  }
}
