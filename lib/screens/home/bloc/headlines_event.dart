part of 'headlines_bloc.dart';

abstract class HeadlinesEvent extends Equatable {
  const HeadlinesEvent();

  @override
  List<Object> get props => [];
}

class HeadlinesFetch extends HeadlinesEvent {
  final String country;
  final String sources;
  const HeadlinesFetch({this.country, this.sources});

  @override
  List<Object> get props => [country];
}
