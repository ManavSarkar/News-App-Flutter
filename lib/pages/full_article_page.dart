import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FullArticle extends StatefulWidget {
  const FullArticle({Key? key, required this.articleUrl}) : super(key: key);
  final String articleUrl;

  @override
  _FullArticleState createState() => _FullArticleState();
}

class _FullArticleState extends State<FullArticle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.articleUrl),
      ),
      body: SafeArea(
        child: Container(
          child: InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse(widget.articleUrl),
            ),
          ),
        ),
      ),
    );
  }
}
