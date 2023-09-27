
import 'package:flutter/material.dart';
import 'package:music_party/View/HomeScreen.dart';

class HomeProvider extends ChangeNotifier{

  ScrollController scrollController = ScrollController();
  bool isVideo=false;
  int? musicIndex;
  int? videoIndex;

  List<String> musicType = [
    'Relax',
    'Energize',
    'Podcasts',
    'Commute',
    'Workout',
    'Focus'
  ];
  List<String> videoType = [
    'Nature',
    'Sunset',
    'Mountains',
    'Workout',
    'Lion',
    'india',
  ];

  void changeFunc(){

    if(isVideo){
      assetsAudioPlayer.pause();
    }
    notifyListeners();
  }

  void isVideos(){
    isVideo=!isVideo;
    notifyListeners();
  }

  void checkMusicType(int index){
    if (musicIndex != index) {
      musicIndex = index;
    } else {
      musicIndex = null;
    }
    notifyListeners();
  }

  void checkVideoType(int index){
    if (videoIndex != index) {
      videoIndex = index;
    } else {
      videoIndex = null;
    }
    notifyListeners();
  }


}