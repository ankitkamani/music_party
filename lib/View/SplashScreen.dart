import 'package:flutter/material.dart';
import 'package:music_party/Utils/Routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),() {
      Navigator.pushReplacementNamed(context, homeScreen);
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      height: deviceSize.height,
      width: deviceSize.width,
      alignment: Alignment.center,
      child: Image.asset('assets/img/splashscreenlogo.jpg'),
    );
  }
}
