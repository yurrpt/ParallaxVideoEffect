import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../animation/parallax_effect.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({
    super.key,
    required this.assetPath,
    required this.isSelected,
  });

  final String assetPath;
  final bool isSelected;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  final GlobalKey _videoKey = GlobalKey();

  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.asset(widget.assetPath);

    _videoPlayerController
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) => setState(() {}))
      ..play();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: widget.isSelected
          ? const EdgeInsets.symmetric(vertical: 16, horizontal: 4)
          : const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 6),
            blurRadius: 8,
          ),
        ],
      ),
      duration: const Duration(seconds: 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Flow(
          delegate: ParallaxFlowDelegate(
            scrollable: Scrollable.of(context),
            listItemContext: context,
            backgroundImageKey: _videoKey,
          ),
          children: [
            AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(
                _videoPlayerController,
                key: _videoKey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
