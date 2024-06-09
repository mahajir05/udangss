import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/errors/app_failure.dart';
import '../../../../../cores/models/data_with_meta.dart';
import '../../../domain/entities/shrimp_price_entity.dart';
import '../../../domain/usecases/get_shrimp_prices_uc.dart';

part 'shrimp_price_event.dart';
part 'shrimp_price_state.dart';

class ShrimpPriceBloc extends Bloc<ShrimpPriceEvent, ShrimpPriceState> {
  final GetShrimpPricesUc getShrimpPriceUc;

  ShrimpPriceBloc({required this.getShrimpPriceUc}) : super(ShrimpPriceInitialState()) {
    on<ShrimpPriceGetEvent>((event, emit) async {
      emit(ShrimpPriceLoadingState(isReset: event.isReset));
      final result = await getShrimpPriceUc(page: event.page, perPage: event.perPage, regionId: event.regionId);
      result.fold(
        (l) => emit(ShrimpPriceFailureState(l, l.code, l.messages)),
        (r) => emit(ShrimpPriceSuccessState(data: r.data, metaData: r.meta, regionId: event.regionId)),
      );
    });
  }
}
