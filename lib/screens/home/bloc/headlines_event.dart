part of 'headlines_bloc.dart';

abstract class HeadlinesEvent extends Equatable {
  const HeadlinesEvent();

  @override
  List<Object> get props => [];
}

class HeadlinesFetchByCountry extends HeadlinesEvent {
  final String country;

  const HeadlinesFetchByCountry({this.country});

  @override
  List<Object> get props => [country];
}

class HeadlinesFetchBySources extends HeadlinesEvent {
  final String sources;

  const HeadlinesFetchBySources({this.sources});

  @override
  List<Object> get props => [sources];
}
