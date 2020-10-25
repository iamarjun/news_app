import 'package:flutter/material.dart';
import 'package:news_app/models/articles.dart';
import 'package:timeago/timeago.dart';

class ArticleWidget extends StatelessWidget {
  final Articles article;

  const ArticleWidget({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(article.description ?? ''),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    format(
                      DateTime.parse(article.publishedAt),
                    ),
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            ),
            Image.network(
              article.urlToImage ?? 'https://image.freepik.com/free-vector/breaking-news-title-template_97886-3228.jpg',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
