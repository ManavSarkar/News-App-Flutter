import 'package:news_app_flutter/model/source_model.dart';

enum NewsCategory { Headlines, Technology }

class Article {
  // final Source source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? image;
  final String? publisher;
  final String? content;
  Article({
    // required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.image,
    required this.publisher,
    required this.content,
  });

  Article.fromJson(Map<String, dynamic> json)
      : this(
          // source: json['source'],
          author: json["author"],
          title: json['title'] as String,
          description: json['description'],
          url: json['url'] as String,
          image: json['urlToImage'],
          publisher: json['publishedAt'] as String,
          content: json['content'],
        );
}
