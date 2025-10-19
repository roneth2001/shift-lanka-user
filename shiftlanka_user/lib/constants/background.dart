import 'package:flutter/material.dart';

class RotatingBackgroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RotatingBackgroundScreen(),
      ),
    );
  }
}

class RotatingBackgroundScreen extends StatefulWidget {
  @override
  State<RotatingBackgroundScreen> createState() =>
      _RotatingBackgroundScreenState();
}

class _RotatingBackgroundScreenState extends State<RotatingBackgroundScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentImageIndex = 0;

  // List of background images - replace with your image paths
  final List<String> backgroundImages = [
    'assets/background/home_bg1.png',
    'assets/background/home_bg2.png',
    'assets/background/home_bg3.png',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image carousel
        PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentImageIndex = index % backgroundImages.length;
            });
            _startAutoSlide();
          },
          itemBuilder: (context, index) {
            return Image.asset(
              backgroundImages[index % backgroundImages.length],
              fit: BoxFit.cover,
            );
          },
        ),
        // Your app content here
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Background Image ${_currentImageIndex + 1}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black54,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Dot indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    backgroundImages.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: _currentImageIndex == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentImageIndex == index
                            ? Colors.white
                            : Colors.white54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(RotatingBackgroundApp());
}