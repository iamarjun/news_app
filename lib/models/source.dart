import 'package:json_annotation/json_annotation.dart';

/// id : "the-times-of-india"
/// name : "The Times of India"

part 'source.g.dart';

@JsonSerializable()
class Source {
  String _id;
  String _name;

  String get id => _id;
  String get name => _name;

  Source({String id, String name}) {
    _id = id;
    _name = name;
  }

  factory Source.fromJson(dynamic json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
