import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/errors/app_failure.dart';
import '../../../domain/entities/shrimp_price_entity.dart';
import '../../../domain/usecases/get_detail_shrimp_price_uc.dart';

part 'detail_shrimp_price_event.dart';
part 'detail_shrimp_price_state.dart';

class DetailShrimpPriceBloc extends Bloc<DetailShrimpPriceEvent, DetailShrimpPriceState> {
  final GetDetailShrimpPriceUc getDetailShrimpPriceUc;

  DetailShrimpPriceBloc({required this.getDetailShrimpPriceUc}) : super(DetailShrimpPriceInitialState()) {
    on<DetailShrimpPriceGetEvent>((event, emit) async {
      emit(DetailShrimpPriceLoadingState());
      final result = await getDetailShrimpPriceUc(id: event.id, regionId: event.regionId);
      result.fold(
        (l) => emit(DetailShrimpPriceFailureState(l, l.code, l.messages)),
        (r) => emit(DetailShrimpPriceSuccessState(data: r)),
      );
    });
  }
}
