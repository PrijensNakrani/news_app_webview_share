import 'package:http/http.dart' as http;

import '../model/news_model.dart';

class ApiService {
  static Future<NewsAPi?> getNews() async {
    http.Response response = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=86d651dd6f944b339a5ba45b687ecf8d"),
    );
    if (response.statusCode == 200) {
      return newsModelFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<NewsAPi?> getNews2() async {
    http.Response response = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=in&apiKey=86d651dd6f944b339a5ba45b687ecf8d"),
    );
    if (response.statusCode == 200) {
      return newsModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
