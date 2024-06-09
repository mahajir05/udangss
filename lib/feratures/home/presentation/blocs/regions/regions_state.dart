part of 'regions_bloc.dart';

sealed class RegionsState extends Equatable {
  const RegionsState();

  @override
  List<Object> get props => [];
}

final class RegionsInitialState extends RegionsState {}

final class RegionsLoadingState extends RegionsState {}

final class RegionsSuccessState extends RegionsState {
  final List<RegionEntity> data;
  final MetaDataApi? metaData;

  const RegionsSuccessState({required this.data, required this.metaData});
}

final class RegionsFailureState extends RegionsState {
  final AppFailure appFailure;
  final int? code;
  final String? message;

  const RegionsFailureState(this.appFailure, this.code, this.message);

  @override
  List<Object> get props => [
        [appFailure, code, message]
      ];
}
