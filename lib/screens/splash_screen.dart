import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      GoRouter.of(context).go('/home'); // Redirige a la pantalla principal
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:
        Column(
          children: [
            Image.asset('assets/images/splash.png'),
            const Text("APP", style: TextStyle(fontSize: 40),)
            //child: LottieBuilder.asset("assets/lottie/splash_animation.json") ,
          ],
        ),
        splashIconSize: 400,
      backgroundColor: Colors.cyan,
      animationDuration: Duration(seconds: 3),
      splashTransition: SplashTransition.scaleTransition,
      nextScreen: Container(),
    );
  }
}