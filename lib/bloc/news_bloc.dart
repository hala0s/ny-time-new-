import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:http/http.dart' as http;
import 'package:ny_times/data/model/ny_model.dart';

part 'news_event.dart';
part 'news_state.dart';


class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc(
    this.httpClient,
  ) : super( NewsState()) {

    on<Newsfetch>(_onNewsFetched);
  }
  final http.Client httpClient;

  Future<void> _onNewsFetched(Newsfetch event, Emitter<NewsState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == NewsStatus.initial) {
        final allResults = await _fetchNews();
        return emit(state.copywith(
            status: NewsStatus.success, allResults: allResults, hasReachedMax: false));
      }
      final allResults = await _fetchNews(state.allResults.length);
      allResults.isEmpty
          ? emit(state.copywith(hasReachedMax: true))
          : emit(state.copywith(
              status: NewsStatus.success,
              allResults: List.of(state.allResults)..addAll(allResults),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copywith(status: NewsStatus.failuer));
    }
  }

  Future<List<AllResults>> _fetchNews([int startIndex = 0]) async {
    try{
      final response = await 
    httpClient.get(
       Uri.parse(
        'https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=aVn6fLWCAZeT5nLi0CJdsWnqqTIThxvy',
      ),
      headers: {'Content-Type': 'application/json; charset=UTF-8'}
    );
    // if (resonse.statusCode == 200) {
      final body = json.decode(response.body)['results'] as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return AllResults.fromJson(map);
      }).toList();
    // }
    }catch (e){
      print(e.toString());
    }
    
    throw Exception('erorr ');
  }
}
