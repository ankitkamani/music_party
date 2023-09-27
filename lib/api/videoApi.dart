import 'package:http/http.dart'as http;
import 'package:music_party/Modal/Video%20Modal.dart';
class Api {
  Future<VideoModel> getData(
      {required String wallPaperType}) async {
    var url = "https://api.pexels.com/videos/search?query=$wallPaperType&per_page=10";
    Uri uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      "Authorization":
      "637yWRRlOMSllCi1rYjFKQN9xl0duTsPKLAeJuzuT657cSbiq7rC6t75"
    });
    return videoModelFromJson(response.body);
  }

  // Future<VideoModel> loadData({required int pgNo,required String wallPaperType}) async{
  //   var url = "https://api.pexels.com/v1/search/?page=$pgNo&query=$wallPaperType&orientation=landscape&size=large";
  //   Uri uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   return videoModelFromJson(response.body);
  // }
}