import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/errors/app_failure.dart';
import '../../../../../cores/models/data_with_meta.dart';
import '../../../domain/entities/region_entity.dart';
import '../../../domain/usecases/get_regions_uc.dart';

part 'regions_event.dart';
part 'regions_state.dart';

class RegionsBloc extends Bloc<RegionsEvent, RegionsState> {
  final GetRegionsUc getRegionsUc;

  RegionsBloc({required this.getRegionsUc}) : super(RegionsInitialState()) {
    on<RegionsSearchEvent>((event, emit) async {
      emit(RegionsLoadingState());
      final result = await getRegionsUc(event.keyword);
      result.fold(
        (l) => emit(RegionsFailureState(l, l.code, l.messages)),
        (r) => emit(RegionsSuccessState(data: r.data, metaData: r.meta)),
      );
    });
  }
}
