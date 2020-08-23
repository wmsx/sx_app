import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:sx_app/ui/widget/video_progress_bar.dart';
import 'package:video_player/video_player.dart';

class MaterialControls extends StatefulWidget {
  const MaterialControls({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MaterialControlsState();
  }
}

class _MaterialControlsState extends State<MaterialControls> {
  final barHeight = 2.0;

  bool _hideStuff = false;

  Timer _hideTimer;
  VideoPlayerValue _latestValue;

  VideoPlayerController controller;
  ChewieController chewieController;

  @override
  void didChangeDependencies() {
    final _oldController = chewieController;
    chewieController = ChewieController.of(context);
    controller = chewieController.videoPlayerController;
    if (_oldController != chewieController) {
      _initialize();
    }

    super.didChangeDependencies();
  }

  Future<Null> _initialize() async {
    controller.addListener(_updateState);
    _updateState();
  }

  void _updateState() {
    setState(() {
      _latestValue = controller.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: GestureDetector(
        onTap: () {
          _cancelAndRestartTimer();
        },
        child: AbsorbPointer(
          absorbing: _hideStuff, // 如果想要响应点击事件只需设置absorbing为false即可：
          child: Column(
            children: [
              _buildHitArea(),
              _buildBottomBar(context),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildExpandButton() {
    return GestureDetector(
      child: AnimatedOpacity(
        opacity: _hideStuff ? 0.0 : 1.0,
        duration: Duration(milliseconds: 300),
        child: Container(
          height: barHeight,
          child: Center(
            child: Icon(
              chewieController.isFullScreen
                  ? Icons.fullscreen_exit
                  : Icons.fullscreen,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildHitArea() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_latestValue != null && _latestValue.isPlaying) {
            _cancelAndRestartTimer();
          } else {
            _playPause();
            setState(() {
              _hideStuff = true;
            });
          }
        },
        child: Container(
          child: Center(
            child: AnimatedOpacity(
              opacity: _hideStuff ? 0.0 : 1.0,
              duration: Duration(milliseconds: 300),
              child: GestureDetector(
                onTap: () {
                  _playPause();
                },
                child: Opacity(
                  opacity: 0.5,
                  child: Icon(
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 100.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _playPause() {
    setState(() {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
    });
  }

  AnimatedOpacity _buildBottomBar(BuildContext context) {
    return AnimatedOpacity(
      opacity: _hideStuff ? 0.0 : 1.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        height: barHeight,
        child: Row(
          children: [
            _buildProgressBar(),
            _buildExpandButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Expanded(
      child: VideoProgressBar(
        controller,
      ),
    );
  }

  void _cancelAndRestartTimer() {
    debugPrint('_cancelAndRestartTimer');
    _hideTimer?.cancel();
    _startHideTimer();
    setState(() {
      _hideStuff = false;
    });
  }

  void _startHideTimer() {
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _hideStuff = true;
      });
    });
  }
}
