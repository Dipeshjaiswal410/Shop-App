import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/components/colors.dart';
import 'package:margintop_solutions/views/loginView/loginScreen.dart';
import 'package:margintop_solutions/views/splashView/splashClipper.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            ClipPath(
              clipper: MountainCurveClipper(),
              child: Material(
                color: appColor,
                child: SizedBox(
                  height: size.height / 1.4,
                  width: size.width,
                  child: Center(
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo.jpg"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Light white bubbles
            Positioned(
              top: size.height * 0.1 - 70,
              left: size.width * 0.2 - 50,
              child: _buildBubble(30, Colors.white.withOpacity(0.2)),
            ),
            Positioned(
              top: size.height * 0.1,
              left: size.width * 0.2,
              child: _buildBubble(60, Colors.white.withOpacity(0.2)),
            ),
            Positioned(
              top: size.height * 0.3,
              right: size.width * 0.15,
              child: _buildBubble(80, Colors.white.withOpacity(0.15)),
            ),
            Positioned(
              top: size.height * 0.5,
              left: size.width * 0.3,
              child: _buildBubble(100, Colors.white.withOpacity(0.1)),
            ),

            Column(
              children: [
                SizedBox(height: size.height / 1.4),
                AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText(
                      "NIKKLE",
                      textStyle: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 20,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Simplify everything with Nikkle: accounting, HR, \nCRM, project management, and credit \napplications!',
                      textAlign: TextAlign.center,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      colors: [
                        Colors.green,
                        Colors.orange,
                        Colors.red,
                        Colors.purple,
                      ],
                      speed: const Duration(milliseconds: 70),
                    ),
                  ],
                  totalRepeatCount: 20,
                ),
                SizedBox(height: size.height / 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 5),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    tileColor: appColor,
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LOGIN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.login, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Bubble creating function
  Widget _buildBubble(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
