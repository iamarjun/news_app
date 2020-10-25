import 'package:flutter/material.dart';
import 'package:news_app/models/articles.dart';
import 'package:news_app/screens/detail/news_webview.dart';
import 'package:news_app/utils/constants.dart';

class NewsDetail extends StatelessWidget {
  final Articles articles;
  static final String route = '/news_detail';
  const NewsDetail({Key key, this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network(
                articles.urlToImage,
                height: MediaQuery.of(context).size.height * 0.35,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
                child: Text(
                  articles.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              articles.source.name,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              articles.publishedAt,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              articles.description,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              NewsWebView.route,
              arguments: articles.url,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'See Full Story',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: kColorPrimary,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: kColorPrimary,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
