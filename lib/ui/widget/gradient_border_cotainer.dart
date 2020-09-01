import 'package:flutter/material.dart';

class GradientBorderContainer extends StatelessWidget {
  final double size;
  final BoxShape shape;
  final ImageProvider image;

  GradientBorderContainer({
    this.size = 20,
    this.shape,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.black, Colors.redAccent]),
        border: Border.all(
          color: Colors.red,
        ),
        shape: this.shape,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            shape: this.shape,
            color: Colors.white,
            border: Border.all(color: Colors.white),
            image: DecorationImage(
              image: this.image,
            ),
          ),
        ),
      ),
    );
  }
}

class CircleBorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: Image.network(
          'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg',
        ),
      ),
    );
  }
}
