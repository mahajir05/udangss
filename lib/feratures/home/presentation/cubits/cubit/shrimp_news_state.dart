part of 'shrimp_news_cubit.dart';

class ShrimpNewsState extends Equatable {
  final List<NewsEntity> news;
  final bool isLoading;
  final bool isError;
  final MetaDataApi? meta;

  const ShrimpNewsState({
    this.news = const [],
    this.isLoading = false,
    this.isError = false,
    this.meta,
  });

  ShrimpNewsState copyWith({
    List<NewsEntity>? news,
    bool? isLoading,
    bool? isError,
    MetaDataApi? meta,
  }) =>
      ShrimpNewsState(
        news: news ?? this.news,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        meta: meta ?? this.meta,
      );

  @override
  List<Object?> get props => [
        news,
        isLoading,
        isError,
        meta,
      ];
}
