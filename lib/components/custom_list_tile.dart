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
          Image.network(
            article.image!,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * (9 / 16),
            fit: BoxFit.fill,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              }
              return AnimatedOpacity(
                child: child,
                opacity: frame == null ? 0 : 1,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            },
            errorBuilder: (context, error, stackTrace) {
              print(error.toString());
              return CircularProgressIndicator();
            },
          ),
          Text(
            article.title!,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            article.description ?? "",
            style: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
            ),
            softWrap: true,
          )
        ],
      ),
    ),
  );
}
