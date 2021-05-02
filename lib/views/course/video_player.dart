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
  }) : super(key: key);

  @override
  _VideoPlayerCourseState createState() => _VideoPlayerCourseState();
}

class _VideoPlayerCourseState extends State<VideoPlayerCourse> {
  late ChewieController _chewieController;
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = initVideoPlayer();
  }

  Future<void> initVideoPlayer() async{
    await widget.videoPlayerController.initialize();
    setState(() {
      _chewieController = ChewieController(
          videoPlayerController: widget.videoPlayerController,
          looping: widget.looping,
          allowFullScreen: false,
          allowMuting: false,
          allowPlaybackSpeedChanging: false,
          allowedScreenSleep: false,
          aspectRatio: widget.videoPlayerController.value.aspectRatio,
          errorBuilder: (context, errorMessage){
            return Center(
                child: Text('Something went wrong'));
            },
          placeholder: PlaceholderImage(),
          customControls: CupertinoControls(
            backgroundColor: Colors.white70,
            iconColor: Colors.teal,
          ),
      );
    });
  }
  PlaceholderImage(){
    return Center(
        child: CircularProgressIndicator()
    );
  }
    @override
    Widget build(BuildContext context) {
      return FutureBuilder(
          future: _future,
          builder:(context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return PlaceholderImage();
            }
            // I get "LateInitializationError: Field '_chewieController@171470877' has not been initialized." whenever i return to a previous video
            if(snapshot.hasError){
              _future;
              return Center(
                  child: Text('Something went wrong'));;
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chewie(
                controller: _chewieController,
              ),
            );
          });
    }

    @override
    void dispose() {
      super.dispose();
      widget.videoPlayerController.dispose();
      _chewieController.dispose();
    }
}
