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

  Future<String> getNotes(String videoId) async {
    final response = await dio.post(
        "https://youtube-data-api-c562.onrender.com/notes",
        data: {'videoId': videoId});
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
    return response.data['data'];
  }
}

YoutubeAPI api = YoutubeAPI();
