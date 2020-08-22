import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:sx_app/ui/widget/video_control.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String url;

  const VideoWidget({Key key, this.url}) : super(key: key);

  @override
  _VideoWidgetState createState() {
    return _VideoWidgetState();
  }
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/trail.mp4')
      // _controller = VideoPlayerController.network(widget.url)
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: ChewieController(
        videoPlayerController: _controller,
        autoPlay: false,
        looping: true,
        aspectRatio: _controller.value.aspectRatio,
        customControls: MaterialControls(),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       debugPrint('===== $_isPlaying');
  //       if (_isPlaying) {
  //         _controller.pause();
  //       } else {
  //         _controller.play();
  //       }
  //     },
  //     onPanEnd: (details) {
  //       _controller.pause();
  //     },
  //     child: AspectRatio(
  //       aspectRatio: _controller.value.aspectRatio,
  //       child: VideoPlayer(_controller),
  //     ),
  //   );
  // }
}
