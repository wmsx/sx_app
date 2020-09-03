import 'package:flutter/material.dart';

class EmptyDashboradWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Image.asset(
            'assets/images/default_avatar.png',
            width: 100,
          ),
          Text(
            '你还没有分享过作品',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '赶紧分享你的学习经验吧',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyFavoriteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Image.asset(
            'assets/images/default_avatar.png',
            width: 100,
          ),
          Text(
            '你还没有收藏过作品',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '把你觉得有用的作品放到这里来吧',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyThumbUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Image.asset(
            'assets/images/default_avatar.png',
            width: 100,
          ),
          Text(
            '你还没有点赞过作品',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '赶紧给你喜欢的作品点赞吧',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
