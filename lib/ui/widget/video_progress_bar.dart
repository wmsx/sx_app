import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoProgressBar extends StatefulWidget {
  final VideoPlayerController videoController;
  final ChewieProgressColors colors;

  VideoProgressBar(
    this.videoController, {
    ChewieProgressColors colors,
  }) : colors = colors ?? ChewieProgressColors();

  @override
  _VideoProgressBarState createState() {
    return _VideoProgressBarState();
  }
}

class _VideoProgressBarState extends State<VideoProgressBar> {
  VideoPlayerController get videoController => widget.videoController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          child: CustomPaint(
            painter: _ProgressBarPainter(
              videoController.value,
              widget.colors,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressBarPainter extends CustomPainter {
  VideoPlayerValue value;
  ChewieProgressColors colors;

  _ProgressBarPainter(
    this.value,
    this.colors,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final height = 2.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(0.0, size.height / 2),
          Offset(size.width, size.height / 2 + height),
        ),
        Radius.circular(2.0),
      ),
      colors.backgroundPaint,
    );
    if (!value.initialized) {
      return;
    }
    final double playedPartPercent =
        value.position.inMilliseconds / value.duration.inMilliseconds;
    final double playedPart =
        playedPartPercent > 1 ? size.width : playedPartPercent * size.width;
    for (DurationRange range in value.buffered) {
      final double start = range.startFraction(value.duration) * size.width;
      final double end = range.endFraction(value.duration) * size.width;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromPoints(
            Offset(start, size.height / 2),
            Offset(end, size.height / 2 + height),
          ),
          Radius.circular(4.0),
        ),
        colors.bufferedPaint,
      );
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          Offset(0.0, size.height / 2),
          Offset(playedPart, size.height / 2 + height),
        ),
        Radius.circular(4.0),
      ),
      colors.playedPaint,
    );
    canvas.drawCircle(
      Offset(playedPart, size.height / 2 + height / 2),
      height * 3,
      colors.handlePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
