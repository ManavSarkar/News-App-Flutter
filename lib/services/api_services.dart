import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app_flutter/model/article_model.dart';

class ApiService {
  final endPointUrl =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=0afa6e7881fb4cb4a3cb7922a65f3f9c";
  Future<List<Article>> getArticles(NewsCategory category) async {
    if (category == NewsCategory.Headlines) {
      print('Working enum correctly');
    }

    Response res = await get(Uri.parse(endPointUrl));
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      print(json);
      List<dynamic> body = json['articles'];
      List<Article> articles =
          body.map((dynamic e) => Article.fromJson(e)).toList();
      return articles;
    } else {
      print('Error in getting the respective file\nplease try again later');
      return [];
    }
  }
}
