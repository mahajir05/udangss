part of 'detail_shrimp_price_bloc.dart';

sealed class DetailShrimpPriceState extends Equatable {
  const DetailShrimpPriceState();

  @override
  List<Object> get props => [];
}

final class DetailShrimpPriceInitialState extends DetailShrimpPriceState {}

final class DetailShrimpPriceLoadingState extends DetailShrimpPriceState {}

final class DetailShrimpPriceSuccessState extends DetailShrimpPriceState {
  final ShrimpPriceEntity data;

  const DetailShrimpPriceSuccessState({required this.data});
}

final class DetailShrimpPriceFailureState extends DetailShrimpPriceState {
  final AppFailure appFailure;
  final int? code;
  final String? message;

  const DetailShrimpPriceFailureState(this.appFailure, this.code, this.message);

  @override
  List<Object> get props => [
        [appFailure, code, message]
      ];
}
