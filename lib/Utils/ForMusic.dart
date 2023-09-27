import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_party/Modal/Video%20Modal.dart';
import 'package:music_party/Providers/HomeProvider.dart';
import 'package:music_party/View/videoScreen.dart';
import 'package:music_party/api/videoApi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../View/HomeScreen.dart';
import 'CarouselSliders/Slider1.dart';
import 'CarouselSliders/Slider2.dart';
import 'Heading.dart';
import 'Songs.dart';

class ForMusic extends StatefulWidget {
  const ForMusic({super.key});

  @override
  State<ForMusic> createState() => _ForMusicState();
}

class _ForMusicState extends State<ForMusic> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, valueP, child) {
        return valueP.isVideo
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height*.8,
                    child: FutureBuilder(
                      future: Api().getData(wallPaperType: valueP.videoType[valueP.videoIndex??0]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data?.videos?.length ?? 0,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      child: VideoScreen(url: snapshot.data?.videos![index].videoFiles?[0].link.toString()??''),
                                      reverseDuration: const Duration(milliseconds: 300),
                                      duration: const Duration(milliseconds: 400)));
                                },
                                child: Container(
                                  height: 200,
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.white10,
                                  child: Image.network(
                                    snapshot.data?.videos?[index].image ?? '',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 18)
                        .copyWith(bottom: 0),
                    child: const Text(
                      'FOR YOU',
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ),
                  Heading(
                      songTypeTitle: 'Trending songs',
                      songTypeButtonTitle: 'Play all',
                      buttonFunction: () {
                        assetsAudioPlayer.open(Playlist(audios: songs),
                            loopMode: LoopMode.playlist,
                            showNotification: true);
                      }),
                  const Slider1(),
                  const Heading(
                    songTypeTitle: 'New release',
                    songTypeButtonTitle: 'More',
                  ),
                  const Slider2(),
                ],
              );
      },
    );
  }
}
