import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_reading/app/modules/homepage/homepage.dart';
import 'package:news_reading/app/widget/circle_progress_painter.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animationController.forward();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(Duration(seconds: 3), () {
      Get.off(() =>   MyHomePage()); // Replace YourMainScreen with your actual main screen
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromARGB(255, 252, 252, 252), // Change border color as needed
                      width: 2.0,
                    ),
                  ),
                  child: ClipOval(
                    child: Image(
                      image: AssetImage('assets/logo.png'), // Replace with your asset image path
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CustomPaint(
                    painter: CircleProgressPainter(
                      animation: _animationController,
                      color: Color.fromARGB(255, 241, 67, 55),
                      strokeWidth: 6.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
