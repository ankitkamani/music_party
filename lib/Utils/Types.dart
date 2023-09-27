import 'package:flutter/material.dart';
import 'package:music_party/Providers/HomeProvider.dart';
import 'package:provider/provider.dart';

class Types extends StatefulWidget {
  const Types({super.key});

  @override
  State<Types> createState() => _VideoTypesState();
}

class _VideoTypesState extends State<Types> {

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, valueP, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: valueP.isVideo
                  ? List.generate(valueP.videoType.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0).copyWith(right: 0),
                        child: InkWell(
                          onTap: () {
                            valueP.checkVideoType(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: valueP.videoIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              valueP.videoType[index],
                              style: TextStyle(
                                  color: valueP.videoIndex == index
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    })
                  : List.generate(valueP.musicType.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0).copyWith(right: 0),
                        child: InkWell(
                          onTap: () {
                            valueP.checkMusicType(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: valueP.musicIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              valueP.musicType[index],
                              style: TextStyle(
                                  color: valueP.musicIndex == index
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }),
            ),
          ),
        );
      },
    );
  }
}
