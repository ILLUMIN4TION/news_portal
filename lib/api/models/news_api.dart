import 'dart:convert';

import 'package:easy_extension/easy_extension.dart';
import 'package:http/http.dart' as http;
import 'package:news_portal/api/api_config.dart';
import 'package:news_portal/api/models/news_data.dart';

class NewsApi {
  static Future<List<NewsData>?> _fetchNews(String url) async {
    final result = await http.get(Uri.parse(url)).catchError((e) {
      Log.red('뉴스리스트 가져오기 오류 $e');
      return http.Response(e.toString(), 400);
    });

    if (result.statusCode != 200) {
      return null;
    }
    final bodyJson = jsonDecode(result.body);
    final List<dynamic> newsRaw = bodyJson['news'];
    return newsRaw.map((data) => NewsData.fromMap(data)).toList();
  }

  static Future<List<NewsData>?> getTopic() =>
      _fetchNews(ApiConfig.news.getTopic);

  static Future<List<NewsData>?> getIssue() =>
      _fetchNews(ApiConfig.news.getIssue);

  static Future<List<NewsData>?> getLastestNews() =>
      _fetchNews(ApiConfig.news.getIssue);
}
