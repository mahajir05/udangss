import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../cores/errors/app_failure.dart';
import '../../../../../cores/models/data_with_meta.dart';
import '../../../domain/entities/disease_entity.dart';
import '../../../domain/usecases/get_diseases_uc.dart';

part 'disease_event.dart';
part 'disease_state.dart';

class DiseaseBloc extends Bloc<DiseaseEvent, DiseaseState> {
  final GetDiseasesUc getDiseasesUc;

  DiseaseBloc({required this.getDiseasesUc}) : super(DiseaseInitialState()) {
    on<DiseaseGetEvent>((event, emit) async {
      emit(DiseaseLoadingState());
      final result = await getDiseasesUc(perPage: event.perPage, page: event.page);
      result.fold(
        (l) => emit(DiseaseFailureState(l, l.code, l.messages)),
        (r) => emit(DiseaseSuccessState(data: r.data, metaData: r.meta)),
      );
    });
  }
}
