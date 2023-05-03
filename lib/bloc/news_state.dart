part of 'news_bloc.dart';

enum NewsStatus { initial, success, failuer }

class NewsState {
  const NewsState(
      {this.status = NewsStatus.initial,
      this.allResults = const <AllResults>[],
      this.hasReachedMax = false,
      });
  final NewsStatus status;
  final List<AllResults> allResults;
  final bool hasReachedMax;
  
  NewsState copywith({
    NewsStatus? status,
    List<Results>? results,
    List<AllResults>? allResults,
    bool? hasReachedMax,
  }) {
    return NewsState(
      status: status ?? this.status,
      allResults: allResults ?? this.allResults,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''NewsState { status: $status, hasReachedMax: $hasReachedMax, posts: ${allResults.length} }''';
  }

  @override
  List<Object> get props => [];
}
