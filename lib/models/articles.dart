import 'package:json_annotation/json_annotation.dart';

import 'source.dart';

/// source : {"id":"the-times-of-india","name":"The Times of India"}
/// author : "TIMESOFINDIA.COM"
/// title : "The exact number of calories you should eat to lose weight - Times of India"
/// description : "Creating a calorie deficit is the first crucial step towards losing weight."
/// url : "https://timesofindia.indiatimes.com/life-style/health-fitness/weight-loss/the-exact-number-of-calories-you-should-eat-to-lose-weight/photostory/78771531.cms"
/// urlToImage : "https://static.toiimg.com/photo/78771581.cms"
/// publishedAt : "2020-10-20T16:30:00Z"
/// content : "1. Harris Benedict Equation\r\nMale: (88.4 + 13.4 x weight in kilograms) + (4.8 x height in centimeters) – (5.68 x age)\r\nFemale: (447.6 + 9.25 x weight in kilograms) + (3.10 x height in centimeters) – … [+123 chars]"

part 'articles.g.dart';

@JsonSerializable()
class Articles {
  Source _source;
  String _author;
  String _title;
  String _description;
  String _url;
  String _urlToImage;
  String _publishedAt;
  String _content;

  Source get source => _source;
  String get author => _author;
  String get title => _title;
  String get description => _description;
  String get url => _url;
  String get urlToImage => _urlToImage;
  String get publishedAt => _publishedAt;
  String get content => _content;

  Articles(
      {Source source,
      String author,
      String title,
      String description,
      String url,
      String urlToImage,
      String publishedAt,
      String content}) {
    _source = source;
    _author = author;
    _title = title;
    _description = description;
    _url = url;
    _urlToImage = urlToImage;
    _publishedAt = publishedAt;
    _content = content;
  }

  factory Articles.fromJson(dynamic json) => _$ArticlesFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesToJson(this);
}
