import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/service/network/api_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/articles.dart';

part 'headlines_event.dart';
part 'headlines_state.dart';

class HeadlinesBloc extends Bloc<HeadlinesEvent, HeadlinesState> {
  final ApiService service;
  String currentCountry;
  String currentSources;
  HeadlinesBloc({@required this.service}) : super(HeadlinesInitial());

  @override
  Stream<Transition<HeadlinesEvent, HeadlinesState>> transformEvents(
      Stream<HeadlinesEvent> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<HeadlinesState> mapEventToState(
    HeadlinesEvent event,
  ) async* {
    final currentState = state;
    int page = 0;

    if (event is HeadlinesFetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is HeadlinesInitial ||
            currentCountry != event.country ||
            currentSources != event.sources) {
          currentCountry = event.country;
          currentSources = event.sources;

          if (currentCountry != null) {
            final articles = await _fetchArticlesByCountry(event.country, page);
            yield HeadlinesSuccess(articles: articles, hasReachedMax: false);
            return;
          }

          if (currentSources != null) {
            final articles = await _fetchArticlesBySources(event.sources, page);
            yield HeadlinesSuccess(articles: articles, hasReachedMax: false);
            return;
          }
        }
        if (currentState is HeadlinesSuccess) {
          currentCountry = event.country;
          currentSources = event.sources;

          if (currentCountry != null) {
            final articles =
                await _fetchArticlesByCountry(event.country, ++page);
            yield articles.isEmpty
                ? currentState.copyWith(hasReachedMax: true)
                : HeadlinesSuccess(
                    articles: currentState.articles + articles,
                    hasReachedMax: false,
                  );
          }

          if (currentSources != null) {
            final articles =
                await _fetchArticlesBySources(event.sources, ++page);
            yield articles.isEmpty
                ? currentState.copyWith(hasReachedMax: true)
                : HeadlinesSuccess(
                    articles: currentState.articles + articles,
                    hasReachedMax: false,
                  );
          }
        }
      } catch (e) {
        print(e);
        yield HeadlinesFailure();
      }
    }
  }

  bool _hasReachedMax(HeadlinesState state) =>
      state is HeadlinesSuccess && state.hasReachedMax;

  Future<List<Articles>> _fetchArticlesByCountry(
      String country, int startIndex) async {
    final response =
        await service.getNewsFromCountry(country ?? 'in', '', startIndex);
    if (response != null) {
      return response.articles;
    } else {
      throw Exception('error fetching posts');
    }
  }

  Future<List<Articles>> _fetchArticlesBySources(
      String sources, int startIndex) async {
    final response =
        await service.getNewsFromSources(sources ?? '', '', startIndex);
    if (response != null) {
      return response.articles;
    } else {
      throw Exception('error fetching posts');
    }
  }
}
