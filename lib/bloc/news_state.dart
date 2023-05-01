part of 'news_bloc.dart';

enum NewsStatus { initial, success, failuer }

class NewsState extends Equatable {
  const NewsState(
      {this.status = NewsStatus.initial,
      this.Result = const <Results>[],
      this.hasReachedMax = false});

  final NewsStatus status;
  final List<Results> Result;
  final bool hasReachedMax;

  NewsState copywith({
    NewsStatus? status,
    List<Results>? Result,
    bool? hasReachedMax,
  }) {
    return NewsState(
      status: status ?? this.status,
      Result: Result ?? this.Result,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${Result.length} }''';
  }

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}
