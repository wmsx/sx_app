import 'package:flutter/material.dart';
import 'package:sx_app/ui/widget/bottom_clipper.dart';

class LoginTopPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        height: 220,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/default_avatar.png',
      width: 130,
      height: 100,
    );
  }
}
