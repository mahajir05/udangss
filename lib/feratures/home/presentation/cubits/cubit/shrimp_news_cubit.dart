import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/models/data_with_meta.dart';
import '../../../domain/entities/news_entity.dart';

part 'shrimp_news_state.dart';

class ShrimpNewsCubit extends Cubit<ShrimpNewsState> {
  ShrimpNewsCubit() : super(const ShrimpNewsState());

  void updateLoadingTrue() => emit(state.copyWith(isLoading: true));
  void updateErrorTrue() => emit(state.copyWith(isError: true));

  void resetShrimpNews() => emit(const ShrimpNewsState());

  void updateShrimpNews({
    required int page,
    required List<NewsEntity> news,
    required MetaDataApi? metaData,
  }) {
    List<NewsEntity> data = [];
    data.addAll(state.news);
    data.addAll(news);
    emit(const ShrimpNewsState());
    emit(state.copyWith(
      news: data,
      isLoading: false,
      isError: false,
      meta: metaData,
    ));
  }
}
