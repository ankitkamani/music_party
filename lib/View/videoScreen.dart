import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'HomeScreen.dart';

class VideoScreen extends StatefulWidget {
  final String url;
  const VideoScreen({super.key,required this.url});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.url),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true)
    )..initialize().then((value) {
      setState(() {});
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: true,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(width: double.infinity,height: 200,child: (videoPlayerController.value.isInitialized)
          ? AspectRatio(
        aspectRatio: videoPlayerController.value.aspectRatio,
        child: Chewie(
          controller: chewieController,
        ),
      )
          : const Center(child: CircularProgressIndicator()),),
    );
  }
  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}


