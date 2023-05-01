// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

import 'package:http/http.dart' as http;
import 'package:ny_times/data/model/ny_model.dart';
import 'package:stream_transform/stream_transform.dart';

part 'news_event.dart';
part 'news_state.dart';

const _Resultlimit = 70;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc(
    this.httpClient,
  ) : super(const NewsState()) {
    on<Newsfetch>(_onNewsFetched,
        transformer: throttleDroppable(throttleDuration));
  }
  final http.Client httpClient;

  Future<void> _onNewsFetched(Newsfetch event, Emitter<NewsState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == NewsStatus.initial) {
        final Result = await _fetchNews();
        return emit(state.copywith(
            status: NewsStatus.success, Result: Result, hasReachedMax: false));
      }
      final Result = await _fetchNews(state.Result.length);
      Result.isEmpty
          ? emit(state.copywith(hasReachedMax: true))
          : emit(state.copywith(
              status: NewsStatus.success,
              Result: List.of(state.Result)..addAll(Result),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copywith(status: NewsStatus.failuer));
    }
  }

  Future<List<Results>> _fetchNews([int startIndex = 0]) async {
    try{
      
      final resonse = await 
    httpClient.get(
      Uri.parse(
        'https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=aVn6fLWCAZeT5nLi0CJdsWnqqTIThxvy',
     
      ),
      headers: {'Content-Type': 'application/json; charset=UTF-8'}
    );
    if (resonse.statusCode == 200) {
      final body = json.decode(resonse.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String?, dynamic>;
        return Results(
          url: map['url'] as String,
          uri: map['uri'] as String,
          id: map['id'] as int,
          source: map['source'] as String,
          date: map['date'] as String,
          type: map['type'] as String,
          title: map['title'] as String,
          abstract: map['abstract'] as String,
          assetId: map['assetId'] as int,
        );
      }).toList();
    }
    }catch (e){
      print(e);
    }
    
    throw Exception('erorr ');
  }
}
