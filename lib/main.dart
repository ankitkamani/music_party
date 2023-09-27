import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_party/Providers/HomeProvider.dart';
import 'package:music_party/Utils/Routes.dart';
import 'package:music_party/View/HomeScreen.dart';
import 'package:music_party/View/PlayerScreen.dart';
import 'package:music_party/View/SplashScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

void main() {
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => HomeProvider(),)
    ],builder: (context, child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Navigator.defaultRouteName,
      routes: {
        Navigator.defaultRouteName:(context) => const SplashScreen(),
        homeScreen:(context) =>const HomeScreen(),
      },
    ));
  }
}
