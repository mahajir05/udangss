part of 'shrimp_price_bloc.dart';

sealed class ShrimpPriceEvent extends Equatable {
  const ShrimpPriceEvent();

  @override
  List<Object?> get props => [];
}

class ShrimpPriceGetEvent extends ShrimpPriceEvent {
  final int? page;
  final int? perPage;
  final int? regionId;
  final bool isReset;

  const ShrimpPriceGetEvent({required this.page, this.perPage, required this.regionId, this.isReset = false});

  @override
  List<Object?> get props => [page, perPage, regionId, isReset];
}
