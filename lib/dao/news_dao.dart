import 'dart:convert';
import 'dart:async';
import 'package:flutter_toutiao/model/news_model.dart';
import 'package:http/http.dart' as http;

const NEWS_URL = 'https://apis.tianapi.com/topnews/index?key=b4b0ec03cb4717c68d63c1c19170aedb';

//首页大接口
class NewsDao {
  static Future<NewsModel> fetch() async {
    final response = await http.get(Uri.parse(NEWS_URL));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //zhongwen
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return NewsModel.fromJson(result);
    } else {
      throw Exception('Failed to load news_page.json');
    }
  }
}