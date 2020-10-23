part of 'headlines_bloc.dart';

abstract class HeadlinesState extends Equatable {
  const HeadlinesState();

  @override
  List<Object> get props => [];
}

class HeadlinesInitial extends HeadlinesState {}

class HeadlinesFailure extends HeadlinesState {}

class HeadlinesSuccess extends HeadlinesState {
  final List<Articles> articles;
  final bool hasReachedMax;

  const HeadlinesSuccess({
    this.articles,
    this.hasReachedMax,
  });

  HeadlinesSuccess copyWith({
    List<Articles> articles,
    bool hasReachedMax,
  }) {
    return HeadlinesSuccess(
      articles: articles ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [articles, hasReachedMax];
}
