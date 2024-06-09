import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/models/data_with_meta.dart';
import '../../../domain/entities/disease_entity.dart';

part 'shrimp_disease_state.dart';

class ShrimpDiseaseCubit extends Cubit<ShrimpDiseaseState> {
  ShrimpDiseaseCubit() : super(const ShrimpDiseaseState());

  void updateLoadingTrue() => emit(state.copyWith(isLoading: true));
  void updateErrorTrue() => emit(state.copyWith(isError: true));

  void resetShrimpDisease() => emit(const ShrimpDiseaseState());

  void updateShrimpDisease({
    required int page,
    required List<DiseaseEntity> shrimpDisease,
    required MetaDataApi? metaData,
  }) {
    List<DiseaseEntity> data = [];
    data.addAll(state.shrimpDisease);
    data.addAll(shrimpDisease);
    emit(const ShrimpDiseaseState());
    emit(state.copyWith(
      shrimpDisease: data,
      isLoading: false,
      isError: false,
      meta: metaData,
    ));
  }
}
