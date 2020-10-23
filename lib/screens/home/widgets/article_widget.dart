import 'package:flutter/material.dart';
import 'package:news_app/models/articles.dart';

class ArticleWidget extends StatelessWidget {
  final Articles article;

  const ArticleWidget({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${article.author}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(article.title),
      isThreeLine: true,
      subtitle: Text(article.description),
      dense: true,
    );
  }
}