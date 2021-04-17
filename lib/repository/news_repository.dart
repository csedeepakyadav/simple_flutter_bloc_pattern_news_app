import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:blocnews/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<List<ArticleModel>> fetchArticle({@required String? country}) async {
    String mainUrl =
        "https://newsapi.org/v2/top-headlines?country=$country&apiKey={Your API KEY HERE}";
    var response = await http.get(Uri.parse(mainUrl));
    List<ArticleModel> _albumlist = [];

    try {
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        for (var item in jsonResponse['articles']) {
          ArticleModel article = new ArticleModel.fromJson(item);

          _albumlist.add(article);
        }
        return _albumlist;
      }
      return _albumlist;
    } catch (e) {
      return _albumlist;
    }
  }
}
