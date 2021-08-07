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
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: DefaultTabController(length: 1, child: HomePage()),
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
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 1, vsync: this);
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
          tabs: [
            Tab(
              child: Text(
                "Headlines",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: tabController!, children: [
        FutureBuilder(
          future: apiService.getArticles(NewsCategory.Headlines),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            List<Article> articles = snapshot.data!;
            print(tabController!.index);
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return customArticleTile(context, articles[index]);
              },
            );
          },
        ),
      ]),
    );
  }
}
