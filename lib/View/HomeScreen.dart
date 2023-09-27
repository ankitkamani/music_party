
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marquee/marquee.dart';
import 'package:music_party/Providers/HomeProvider.dart';
import 'package:music_party/Utils/ForMusic.dart';
import 'package:music_party/View/PlayerScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Utils/Songs.dart';
import '../Utils/Types.dart';

late AssetsAudioPlayer assetsAudioPlayer;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    assetsAudioPlayer.open(songs[0], showNotification: true, autoStart: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(
                sigmaY: 5 * MediaQuery
                    .of(context)
                    .size
                    .width * .069,
                sigmaX: 15), //for old do x=5 y=5
            child: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height *
                          .18, //if do original size of image .38
                      child: Image.asset(
                        'assets/img/relex.jpg',
                        fit: BoxFit.cover,
                      )),
                  Expanded(
                      child: Container(
                        color: Colors.black,
                      ))
                ],
              ),
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                controller: Provider
                    .of<HomeProvider>(context, listen: false)
                    .scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset('assets/img/musiclogo.svg',
                              width: 100),
                          const Spacer(),
                          Consumer<HomeProvider>(
                              builder: (context, value, child) {
                                return Switch(
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.white12,
                                  inactiveThumbColor: Colors.white,
                                  focusColor: Colors.white,
                                  hoverColor: Colors.white10,
                                  thumbIcon: MaterialStatePropertyAll(Icon(
                                    value.isVideo
                                        ? Icons.slow_motion_video_outlined
                                        : Icons.music_note_outlined,
                                    color: Colors.black,
                                  )),
                                  inactiveTrackColor: Colors.white12,
                                  value: value.isVideo,
                                  onChanged: (value1) {
                                    value.isVideos();
                                    value.changeFunc();
                                  },
                                );
                              }),
                          const SizedBox(
                            width: 20,
                          ),
                          const CircleAvatar(
                            foregroundImage:
                            AssetImage('assets/img/splashscreenlogo.jpg'),
                          )
                        ],
                      ),
                    ),
                    const Types(),
                    const ForMusic()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Consumer<HomeProvider>(
        builder: (context, valueP, child) {
          return valueP.isVideo?const SizedBox():InkWell(
          onTap: () {
            Navigator.push(context, PageTransition(
                type: PageTransitionType.bottomToTop,
                child: const PlayerScreen(),
                reverseDuration: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 400)));
          },
          child: Container(
              color: Colors.white10,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .092,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //make provider and use it for true false like visibility
                  // assetsAudioPlayer.current.valueOrNull != null
                  //     ?
                  StreamBuilder<Duration?>(
                      stream: assetsAudioPlayer.currentPosition,
                      builder: (context, snapshot) {
                        double valueee;
                        if (snapshot.hasData) {
                          Duration duration =
                              snapshot.data ?? const Duration(seconds: 0);
                          valueee = ((duration.inSeconds) /
                              (assetsAudioPlayer
                                  .current.value?.audio.duration.inSeconds ??
                                  1));
                        } else {
                          valueee = 0.0;
                        }
                        return LinearProgressIndicator(
                            minHeight: 1,
                            color: Colors.white70,
                            value: valueee,
                            backgroundColor: Colors.black26);
                      }),
                  // : Container(),
                  ListTile(
                    leading: StreamBuilder(
                        stream: assetsAudioPlayer.current,
                        builder: (context, snapshot) {
                          return Hero(tag: 'player',
                            child: Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .07,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height * .07,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Image.asset(
                                    fit: BoxFit.fill,
                                    snapshot.data?.audio.audio.metas.image?.path ??
                                        '')),
                          );
                        }),
                    trailing: StreamBuilder<bool>(
                        stream: assetsAudioPlayer.isPlaying,
                        builder: (context, snapshot) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    snapshot.data ?? false
                                        ? assetsAudioPlayer.pause()
                                        : assetsAudioPlayer.play();
                                  },
                                  icon: Icon(
                                    snapshot.data ?? false
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    if (assetsAudioPlayer.currentLoopMode ==
                                        LoopMode.playlist) {
                                      assetsAudioPlayer.next(stopIfLast: true);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.skip_next,
                                    color: Colors.white,
                                  )),
                            ],
                          );
                        }),
                    title: StreamBuilder(
                        stream: assetsAudioPlayer.current,
                        builder: (context, snapshot) {
                          return SizedBox(
                              width: 60,
                              height: 20,
                              child: Marquee(
                                text: snapshot.data?.audio.audio.metas.title ??
                                    'Nothing To Play',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                scrollAxis: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                blankSpace: 20.0,
                                velocity: 100.0,
                                startPadding: 10.0,
                                pauseAfterRound: const Duration(seconds: 1),
                                fadingEdgeEndFraction: 0.3,
                                fadingEdgeStartFraction: 0.3,
                                textScaleFactor: 1,
                                accelerationDuration: const Duration(seconds: 1),
                                accelerationCurve: Curves.linear,
                                decelerationDuration:
                                const Duration(milliseconds: 500),
                                decelerationCurve: Curves.easeInOut,
                              ));
                        }),
                    subtitle: StreamBuilder(
                        stream: assetsAudioPlayer.current,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data?.audio.audio.metas.artist ?? '',
                            style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                  )
                ],
              )),
        );
        },
      ),
    );
  }
}

