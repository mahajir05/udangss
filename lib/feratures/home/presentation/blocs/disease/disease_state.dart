part of 'disease_bloc.dart';

sealed class DiseaseState extends Equatable {
  const DiseaseState();

  @override
  List<Object> get props => [];
}

final class DiseaseInitialState extends DiseaseState {}

final class DiseaseLoadingState extends DiseaseState {}

final class DiseaseSuccessState extends DiseaseState {
  final List<DiseaseEntity> data;
  final MetaDataApi? metaData;

  const DiseaseSuccessState({required this.data, required this.metaData});
}

final class DiseaseFailureState extends DiseaseState {
  final AppFailure appFailure;
  final int? code;
  final String? message;

  const DiseaseFailureState(this.appFailure, this.code, this.message);

  @override
  List<Object> get props => [
        [appFailure, code, message]
      ];
}
