import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import "sources.dart";

part 'source_response.g.dart';

@JsonSerializable()
class SourceResponse extends Equatable  {
	@JsonKey(name: 'status')
	final String status;
	@JsonKey(name: 'sources')
	final List<Sources> sources;

	SourceResponse({this.status, this.sources});

	factory SourceResponse.fromJson(Map<String, dynamic> json) => _$SourceResponseFromJson(json);

	Map<String, dynamic> toJson() => _$SourceResponseToJson(this);

	@override
	List<Object> get props => [
		this.status,
		this.sources
	];
}
