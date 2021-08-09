import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app_flutter/model/article_model.dart';
import 'package:news_app_flutter/services/api_services.dart';

import 'components/custom_list_tile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Mail',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ApiService apiService = ApiService();
  List<List<Article>> articles = [[], [], [], [], [], [], []];
  bool loading = false;
  TabController? _controller;
  _getAllArticles(NewsCategory category) async {
    setState(() {
      loading = true;
    });
    List<Article> temp = await apiService.getArticles(category);
    setState(() {
      articles[category.index] = temp;
      log(category.index.toString());
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 7, vsync: this);
    _controllerListener();
    _getAllArticles(NewsCategory.headlines);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News Mail",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _controller!,
          isScrollable: true,
          labelColor: Colors.black,
          enableFeedback: true,
          automaticIndicatorColorAdjustment: true,
          tabs: [
            Tab(
              icon: Icon(Icons.trending_up),
              text: "Headlines",
            ),
            Tab(
              icon: Icon(Icons.paid),
              text: "Business",
            ),
            Tab(
              icon: Icon(Icons.theater_comedy),
              text: "Entertainment",
            ),
            Tab(
              icon: Icon(Icons.accessibility),
              text: "Health",
            ),
            Tab(
              icon: Icon(Icons.sensors),
              text: "Science",
            ),
            Tab(
              icon: Icon(Icons.sports),
              text: "Sports",
            ),
            Tab(
              icon: Icon(Icons.settings_input_antenna),
              text: "Technology",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          newsHolder(NewsCategory.headlines),
          newsHolder(NewsCategory.business),
          newsHolder(NewsCategory.entertainment),
          newsHolder(NewsCategory.health),
          newsHolder(NewsCategory.science),
          newsHolder(NewsCategory.sports),
          newsHolder(NewsCategory.technology),
        ],
      ),
    );
  }

  Widget newsHolder(NewsCategory newsCategory) {
    return RefreshIndicator(
      onRefresh: () async {
        await _getAllArticles(newsCategory);
      },
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: Visibility(
        replacement: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Pull down to refresh"),
              ElevatedButton(
                onPressed: () {
                  _getAllArticles(newsCategory);
                },
                child: Text("Refresh"),
              ),
            ],
          ),
        ),
        visible: articles.isNotEmpty,
        child: ListView.builder(
          itemCount: articles[newsCategory.index].length,
          itemBuilder: (context, index) {
            return customArticleTile(
                context, articles[newsCategory.index][index]);
          },
        ),
      ),
    );
  }

  void _controllerListener() {
    _controller!.addListener(() {
      log(_controller!.index.toString());
      _getAllArticles(getCategoryFromIndex(_controller!.index));
    });
  }
}

NewsCategory getCategoryFromIndex(int index) {
  switch (index) {
    case 0:
      return NewsCategory.headlines;
    case 1:
      return NewsCategory.business;
    case 2:
      return NewsCategory.entertainment;
    case 3:
      return NewsCategory.health;
    case 4:
      return NewsCategory.science;
    case 5:
      return NewsCategory.sports;
    case 6:
      return NewsCategory.technology;
  }
  return NewsCategory.headlines;
}
