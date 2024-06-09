part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class NewsInitialState extends NewsState {}

final class NewsLoadingState extends NewsState {}

final class NewsSuccessState extends NewsState {
  final List<NewsEntity> data;
  final MetaDataApi? metaData;

  const NewsSuccessState({required this.data, required this.metaData});
}

final class NewsFailureState extends NewsState {
  final AppFailure appFailure;
  final int? code;
  final String? message;

  const NewsFailureState(this.appFailure, this.code, this.message);

  @override
  List<Object> get props => [
        [appFailure, code, message]
      ];
}
