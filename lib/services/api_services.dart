import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app_flutter/model/article_model.dart';

class ApiService {
  Future<List<Article>> getArticles(NewsCategory category) async {
    final endPointUrl =
        "https://newsapi.org/v2/top-headlines?country=in${_categoryName(category)}&apiKey=0afa6e7881fb4cb4a3cb7922a65f3f9c";

    Response res = await get(Uri.parse(endPointUrl));
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      print(json);
      List<dynamic> body = json['articles'];

      List<Article> articles =
          body.map((dynamic e) => Article.fromJson(e)).toList();

      articles.removeWhere((element) => element.image == null);

      return articles;
    } else {
      print('Error in getting the respective file\nplease try again later');
      return [];
    }
  }
}

String _categoryName(NewsCategory category) {
  switch (category) {
    case NewsCategory.headlines:
      return "";

    case NewsCategory.business:
      return "&category=business";

    case NewsCategory.entertainment:
      return "&category=entertainment";

    case NewsCategory.health:
      return "&category=health";

    case NewsCategory.science:
      return "&category=science";

    case NewsCategory.sports:
      return "&category=sports";

    case NewsCategory.technology:
      return "&category=technology";
  }
}
