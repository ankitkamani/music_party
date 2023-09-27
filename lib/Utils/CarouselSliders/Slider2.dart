import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:music_party/View/HomeScreen.dart';

import '../Songs.dart';

class Slider2 extends StatelessWidget {
  const Slider2({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
            height: MediaQuery
                .of(context)
                .size
                .height * .25,
            initialPage: 0,
            viewportFraction: 0.5,
            padEnds: false,
            enableInfiniteScroll: false,
            scrollPhysics: const BouncingScrollPhysics(),
            pageSnapping: false),
        items: List.generate(songs.length - 1, (index) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10)
                    .copyWith(right: 0),
                child: InkWell(
                  onTap: () {
                    assetsAudioPlayer.open(songs[index], showNotification: true, autoStart: true);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height *
                                .17,
                            child: Image.asset(
                                songs[index].metas.image?.path ??
                                    "",
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height *
                                    .15,
                                fit: BoxFit.fill),
                          ),
                          Text(
                            songs[index].metas.title ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.white),
                          ),
                          Text(songs[index].metas.artist ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white54))
                        ]),
                  ),
                ),
              );
            },
          );
        }));
  }
}
