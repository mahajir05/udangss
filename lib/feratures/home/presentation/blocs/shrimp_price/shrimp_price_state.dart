part of 'shrimp_price_bloc.dart';

sealed class ShrimpPriceState extends Equatable {
  const ShrimpPriceState();

  @override
  List<Object?> get props => [];
}

final class ShrimpPriceInitialState extends ShrimpPriceState {}

final class ShrimpPriceLoadingState extends ShrimpPriceState {
  final bool isReset;

  const ShrimpPriceLoadingState({required this.isReset});

  @override
  List<Object?> get props => [isReset];
}

final class ShrimpPriceSuccessState extends ShrimpPriceState {
  final List<ShrimpPriceEntity> data;
  final MetaDataApi? metaData;
  final int? regionId;

  const ShrimpPriceSuccessState({required this.data, required this.metaData, required this.regionId});

  @override
  List<Object?> get props => [data, metaData];
}

final class ShrimpPriceFailureState extends ShrimpPriceState {
  final AppFailure appFailure;
  final int? code;
  final String? message;

  const ShrimpPriceFailureState(this.appFailure, this.code, this.message);

  @override
  List<Object?> get props => [
        [appFailure, code, message]
      ];
}
