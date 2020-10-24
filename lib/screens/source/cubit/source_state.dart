part of 'source_cubit.dart';

abstract class SourceState extends Equatable {
  const SourceState();

  @override
  List<Object> get props => [];
}

class SourceInitial extends SourceState {}

class SourceFailure extends SourceState {}

class SourceSuccess extends SourceState {
  final List<Sources> sources;

  const SourceSuccess({this.sources});

  @override
  List<Object> get props => [sources];
}
