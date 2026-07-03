import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideo extends StatefulWidget {
  final String url;
  final bool isLocal;
  const FullScreenVideo({super.key, required this.url, required this.isLocal});

  @override
  State<FullScreenVideo> createState() => FullScreenVideoState();
}

class FullScreenVideoState extends State<FullScreenVideo> {
  late VideoPlayerController _ctrl;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _ctrl = widget.isLocal
        ? VideoPlayerController.file(File(widget.url))
        : VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _ctrl.initialize().then((_) {
      if (mounted) {
        setState(() => _initialized = true);
        _ctrl.play();
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: _initialized
            ? AspectRatio(
                aspectRatio: _ctrl.value.aspectRatio,
                child: VideoPlayer(_ctrl),
              )
            : const CircularProgressIndicator(color: Colors.white),
      ),
      floatingActionButton: _initialized
          ? FloatingActionButton(
              backgroundColor: Colors.white24,
              onPressed: () => setState(() {
                _ctrl.value.isPlaying ? _ctrl.pause() : _ctrl.play();
              }),
              child: Icon(
                _ctrl.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
