import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'sources.g.dart';

@JsonSerializable()
class Sources extends Equatable {
  @JsonKey(name: 'id')
  String _id;
  @JsonKey(name: 'name')
  String _name;
  @JsonKey(name: 'description')
  String _description;
  @JsonKey(name: 'url')
  String _url;
  @JsonKey(name: 'category')
  String _category;
  @JsonKey(name: 'language')
  String _language;
  @JsonKey(name: 'country')
  String _country;
  @JsonKey(ignore: true)
  bool _isSelected;

  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get url => _url;
  String get category => _category;
  String get language => _language;
  String get country => _country;
  bool get isSelected => _isSelected;
  set setSelected(value) => _isSelected = value;

  Sources({
    String id,
    String name,
    String description,
    String url,
    String category,
    String language,
    String country,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _url = url;
    _category = category;
    _language = language;
    _country = country;
    setSelected = false;
  }

  factory Sources.fromJson(Map<String, dynamic> json) =>
      _$SourcesFromJson(json);

  Map<String, dynamic> toJson() => _$SourcesToJson(this);

  @override
  List<Object> get props =>
      [_id, _name, _description, _url, _category, _language, _country];
}
