import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/errors/app_failure.dart';
import '../../../../../cores/models/data_with_meta.dart';
import '../../../domain/entities/news_entity.dart';
import '../../../domain/usecases/get_news_uc.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUc getNewsUc;

  NewsBloc({required this.getNewsUc}) : super(NewsInitialState()) {
    on<NewsGetEvent>((event, emit) async {
      emit(NewsLoadingState());
      final result = await getNewsUc(perPage: event.perPage, page: event.page);
      result.fold(
        (l) => emit(NewsFailureState(l, l.code, l.messages)),
        (r) => emit(NewsSuccessState(data: r.data, metaData: r.meta)),
      );
    });
  }
}
