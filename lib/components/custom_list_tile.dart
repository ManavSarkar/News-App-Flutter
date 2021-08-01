import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/model/article_model.dart';
import 'package:news_app_flutter/pages/full_article_page.dart';

Widget customArticleTile(BuildContext context, Article article) {
  return Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => FullArticle(articleUrl: article.url!)));
      },
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * .75,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: Image.network(
              article.image!,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            article.title!,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            article.description!,
            style: TextStyle(
              fontSize: 18.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    ),
  );
}
