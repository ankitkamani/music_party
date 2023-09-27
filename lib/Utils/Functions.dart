
import 'package:assets_audio_player/assets_audio_player.dart';

import '../View/HomeScreen.dart';

void songPlayer({required Audio audio}){
  assetsAudioPlayer.open(audio);
}