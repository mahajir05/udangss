import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/region_entity.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  void selectRegion(RegionEntity? region) {
    emit(state.copyWith(selectedRegion: region));
  }
}
