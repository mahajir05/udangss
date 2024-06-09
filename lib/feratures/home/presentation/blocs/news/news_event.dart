part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class NewsGetEvent extends NewsEvent {
  final int? perPage;
  final int? page;

  const NewsGetEvent({required this.perPage, required this.page});

  @override
  List<Object?> get props => [perPage, page];
}
