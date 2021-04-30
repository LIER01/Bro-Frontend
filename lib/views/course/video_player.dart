import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';


class VideoPlayerCourse extends StatefulWidget {

  final VideoPlayerController videoPlayerController;
  final bool looping;

  VideoPlayerCourse({
    required this.videoPlayerController,
    required this.looping,
    Key? key,
}) : super (key: key);

  @override
  _VideoPlayerCourseState createState() => _VideoPlayerCourseState();
}

class _VideoPlayerCourseState extends State<VideoPlayerCourse> {
  late ChewieController _chewieController;
  @override
  void initState(){
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16/9,
      autoInitialize: true,
      looping: widget.looping,

    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
  @override
  void dispose(){
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
