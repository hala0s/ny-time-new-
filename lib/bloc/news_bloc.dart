import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:http/http.dart' as http;
import 'package:ny_times/data/model/ny_model.dart';

part 'news_event.dart';
part 'news_state.dart';


class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc(
    this.httpClient
  ) : super( const NewsState()) {

    on<Newsfetch>(_onNewsFetched);
  }
  final http.Client httpClient;

  Future<void> _onNewsFetched(Newsfetch event, Emitter<NewsState> emit) async {
    try {

      final allResults = await _fetchNews();
       emit(state.copywith(
              status: NewsStatus.success,
              allResults: allResults,
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copywith(status: NewsStatus.failuer));
    }
  }

  Future<AllResults> _fetchNews() async {
    try{
      final response = await 
    httpClient.get(
       Uri.parse(
        'https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=aVn6fLWCAZeT5nLi0CJdsWnqqTIThxvy',
      ),
      headers: {'Content-Type': 'application/json; charset=UTF-8'}
    );
    // if (resonse.statusCode == 200) {
      final body = json.decode(response.body) ;
      return AllResults.fromJson(body);
    // }
    }catch (e){
      print(e.toString());
    }
    
    throw Exception('erorr ');
  }
}
