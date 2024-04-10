import 'package:dio/dio.dart';

class YoutubeAPI {
  String baseURL = "https://youtube-data-api-c562.onrender.com/query";
  late Map<String, dynamic> fdata = {};
  final dio = Dio();

  Future<Map<String, dynamic>> getSearchResults(String query) async {
    final response = await dio.post(baseURL, data: {"query": query});
    fdata = response.data['response'];
    return fdata;
  }

  Future<String> getNotes(String videoId, String difficulty) async {
    final response = await dio.post(
        "https://youtube-data-api-c562.onrender.com/notes",
        data: {'videoId': videoId, 'difficulty': difficulty});
    if (response.data['status'] == 'false') {
      return 'no notes';
    }
    return response.data['notes'];
  }

  Future<Map<String, dynamic>> getVideoDetails(String videoId) async {
    final response = await dio.post(
        "https://youtube-data-api-c562.onrender.com/videoDetails",
        data: {'videoId': videoId});
    return response.data['data'];
  }

  Future<Map<String, dynamic>> getQuiz(String videoId) async {
    final response = await dio.post(
        "https://youtube-data-api-c562.onrender.com/generateQuiz",
        data: {'videoId': videoId});
    return response.data;
  }

  Future<Map<dynamic, dynamic>> uploadImageToServer(
      String filePath, String text, String ocrResponse) async {
    String ocrUrl = 'https://youtube-data-api-c562.onrender.com/ocr';
    String chatUrl = 'https://youtube-data-api-c562.onrender.com/chat';

    if (filePath != "") {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: 'image.jpg'),
      });

      var response = await Dio().post(ocrUrl, data: formData);
      ocrResponse = response.data;
    }
    var response =
        await Dio().post(chatUrl, data: {'ocr': ocrResponse, 'text': text});
    print(response.data);
    return {"text": response.data['text'], "ocrResponse": ocrResponse};
  }
}

YoutubeAPI api = YoutubeAPI();
