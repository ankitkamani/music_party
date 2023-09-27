import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_party/Providers/HomeProvider.dart';
import 'package:music_party/View/HomeScreen.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(children: [
          StreamBuilder<Playing?>(
              stream: assetsAudioPlayer.current,
              builder: (context, snapshot) {
                return Expanded(
                    child: Stack(
                  fit: StackFit.expand,
                  children: [
                    StreamBuilder<Playing?>(
                        stream: assetsAudioPlayer.current,
                        builder: (context, snapshot) {
                          return ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 45, sigmaY: 25),
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.asset(
                                  snapshot.data?.audio.audio.metas.image
                                          ?.path ??
                                      '',
                                  fit: BoxFit.fill),
                            ),
                          );
                        }),
                    Positioned(
                      right: 0,
                      left: 0,
                      top: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  CupertinoIcons.chevron_down,
                                  color: Colors.white,
                                )),
                            const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    Consumer<HomeProvider>(
                      builder: (context, valueP, child) =>
                      // valueP.isVideo
                          // ? Center(
                          //     child: Column(
                          //       mainAxisSize: MainAxisSize.min,
                          //       children: [
                          //         Container(
                          //           child: (videoPlayerController
                          //                   .value.isInitialized)
                          //               ? Expanded(
                          //                 child: Chewie(
                          //                     controller: chewieController,
                          //                   ),
                          //               )
                          //               : CircularProgressIndicator(),
                          //         ),
                          //         VideoProgressIndicator(videoPlayerController,
                          //             allowScrubbing: true),
                          //         // IconButton(
                          //         //   onPressed: () {
                          //         //     if (videoPlayerController
                          //         //         .value.isPlaying) {
                          //         //       videoPlayerController.pause();
                          //         //     } else {
                          //         //       videoPlayerController.play();
                          //         //     }
                          //         //     setState(() {});
                          //         //   },
                          //         //   icon: Icon(
                          //         //       videoPlayerController.value.isPlaying
                          //         //           ? Icons.pause
                          //         //           : Icons.play_arrow),
                          //         // )
                          //       ],
                          //     ),
                          //   )
                          // :
                      Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  snapshot.hasData
                                      ? Hero(
                                          tag: 'player',
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .3,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Image.asset(
                                                  fit: BoxFit.fill,
                                                  snapshot.data?.audio.audio
                                                          .metas.image?.path ??
                                                      '')),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  StreamBuilder(
                                      stream: assetsAudioPlayer.current,
                                      builder: (context, snapshot) {
                                        return SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                .6,
                                            height: 30,
                                            child: Marquee(
                                              text: snapshot.data?.audio.audio
                                                      .metas.title ??
                                                  'Nothing To Play',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: Colors.white),
                                              scrollAxis: Axis.horizontal,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              blankSpace: 20.0,
                                              velocity: 100.0,
                                              startPadding: 10.0,
                                              pauseAfterRound:
                                                  const Duration(seconds: 1),
                                              fadingEdgeEndFraction: 0.3,
                                              fadingEdgeStartFraction: 0.3,
                                              textScaleFactor: 1,
                                              accelerationDuration:
                                                  const Duration(seconds: 1),
                                              accelerationCurve: Curves.linear,
                                              decelerationDuration:
                                                  const Duration(
                                                      milliseconds: 500),
                                              decelerationCurve:
                                                  Curves.easeInOut,
                                            ));
                                      }),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  StreamBuilder(
                                      stream: assetsAudioPlayer.current,
                                      builder: (context, snapshot) {
                                        return Text(
                                          snapshot.data?.audio.audio.metas
                                                  .artist ??
                                              '',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        );
                                      }),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  StreamBuilder<Duration>(
                                      stream: assetsAudioPlayer.currentPosition,
                                      builder: (context, snapshot) {
                                        Duration duration = snapshot.data ??
                                            const Duration(seconds: 0);
                                        Duration totalSongTime = Duration(
                                            minutes: assetsAudioPlayer
                                                    .current
                                                    .value
                                                    ?.audio
                                                    .duration
                                                    .inMinutes ??
                                                0,
                                            seconds: assetsAudioPlayer
                                                    .current
                                                    .value!
                                                    .audio
                                                    .duration
                                                    .inSeconds %
                                                60);
                                        Duration runTime = Duration(
                                            minutes: duration.inMinutes % 60,
                                            seconds: duration.inSeconds % 60);
                                        Duration totl = totalSongTime - runTime;
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Slider(
                                              value:
                                                  duration.inSeconds.toDouble(),
                                              min: 0,
                                              max: (assetsAudioPlayer
                                                          .current
                                                          .value
                                                          ?.audio
                                                          .duration
                                                          .inSeconds ??
                                                      0)
                                                  .toDouble(),
                                              onChanged: (value) {
                                                assetsAudioPlayer.seek(Duration(
                                                    seconds: value.toInt()));
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 35),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "-${totl.toString().substring(2, 7)}",
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  // Text(
                                                  //     runTime.toString().substring(2,7)),
                                                  Text(
                                                    totalSongTime
                                                        .toString()
                                                        .substring(2, 7),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                            StreamBuilder<bool>(
                                                stream:
                                                    assetsAudioPlayer.isPlaying,
                                                builder: (context, snapshot) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 8.0,
                                                            vertical: 20)
                                                        .copyWith(bottom: 0),
                                                    child: Row(
                                                      // mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        const SizedBox(),
                                                        IconButton(
                                                            onPressed: () {
                                                              if (assetsAudioPlayer
                                                                      .currentLoopMode ==
                                                                  LoopMode
                                                                      .playlist) {
                                                                assetsAudioPlayer
                                                                    .previous();
                                                              }
                                                            },
                                                            icon: const Icon(
                                                              Icons
                                                                  .skip_previous,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                        FloatingActionButton(
                                                            onPressed: () {
                                                              snapshot.data ??
                                                                      false
                                                                  ? assetsAudioPlayer
                                                                      .pause()
                                                                  : assetsAudioPlayer
                                                                      .play();
                                                            },
                                                            child: Icon(snapshot
                                                                        .data ??
                                                                    false
                                                                ? Icons.pause
                                                                : Icons
                                                                    .play_arrow)),
                                                        IconButton(
                                                            onPressed: () {
                                                              if (assetsAudioPlayer
                                                                      .currentLoopMode ==
                                                                  LoopMode
                                                                      .playlist) {
                                                                assetsAudioPlayer
                                                                    .next(
                                                                        stopIfLast:
                                                                            true);
                                                              }
                                                            },
                                                            icon: const Icon(
                                                              Icons.skip_next,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                        const SizedBox(),
                                                      ],
                                                    ),
                                                  );
                                                })
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                    ),
                  ],
                ));
              }),
        ]),
      ),
    );
  }
}
