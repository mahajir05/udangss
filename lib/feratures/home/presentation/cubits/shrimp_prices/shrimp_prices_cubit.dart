import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/models/data_with_meta.dart';
import '../../../domain/entities/shrimp_price_entity.dart';

part 'shrimp_prices_state.dart';

class ShrimpPricesCubit extends Cubit<ShrimpPricesState> {
  ShrimpPricesCubit() : super(const ShrimpPricesState());

  void updateLoadingTrue() => emit(state.copyWith(isLoading: true));
  void updateErrorTrue() => emit(state.copyWith(isError: true));

  void resetShrimpPrice() => emit(const ShrimpPricesState());

  void updateShrimpPrice({
    required int page,
    required List<ShrimpPriceEntity> shrimpPrices,
    required MetaDataApi? metaData,
    required int? regionId,
  }) {
    List<ShrimpPriceEntity> data = [];
    data.addAll(state.shrimpPrices);
    data.addAll(shrimpPrices);
    emit(const ShrimpPricesState());
    emit(state.copyWith(
      shrimpPrices: data,
      isLoading: false,
      isError: false,
      meta: metaData,
      regionId: regionId,
    ));
  }
}
