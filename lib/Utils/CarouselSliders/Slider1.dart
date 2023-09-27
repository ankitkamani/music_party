import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../View/HomeScreen.dart';
import '../Songs.dart';

class Slider1 extends StatelessWidget {
  const Slider1({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
            height: MediaQuery.of(context).size.height * .4,
            initialPage: 0,
            viewportFraction: 0.945,
            padEnds: false,
            scrollPhysics: const BouncingScrollPhysics(),
            enableInfiniteScroll: false),
        items: List.generate(5, (mIndex) {
          return Builder(
            builder: (BuildContext context) {
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(4, (index) {
                        int fIndex = mIndex == 1
                            ? index + 4
                            : mIndex == 2
                                ? index + 8
                                : mIndex == 3
                                    ? index
                                    : mIndex == 4
                                        ? index + 4
                                        : index;
                        return ListTile(
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              songs[fIndex].metas.image?.path ?? "",
                              fit: BoxFit.fill,
                            ),
                          ),
                          onTap: () {
                            if(assetsAudioPlayer.currentLoopMode==LoopMode.playlist){
                              assetsAudioPlayer.playlistPlayAtIndex(fIndex);
                            }else{
                              assetsAudioPlayer.open(songs[fIndex], showNotification: true, autoStart: true);
                            }
                          },
                          title: Text(
                            songs[fIndex].metas.title ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(songs[fIndex].metas.artist ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white54)),
                          trailing: const Icon(
                            Icons.more_vert,
                            size: 22,
                            color: Colors.white70,
                          ),
                        );
                      })));
            },
          );
        }));
  }
}
