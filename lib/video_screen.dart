import 'package:flutter/material.dart';
import 'package:flutter_parallax_effect/model/video_card_model.dart';
import 'package:flutter_parallax_effect/constants/video_constants.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: PageView.builder(
              controller: _pageController,
              itemCount: VideoConstants.videos.length,
              onPageChanged: (value) => setState(() {
                _selectedIndex = value;
              }),
              itemBuilder: (context, index) => VideoCard(
                isSelected: _selectedIndex == index,
                assetPath: VideoConstants.videos[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
