part of 'detail_shrimp_price_bloc.dart';

sealed class DetailShrimpPriceEvent extends Equatable {
  const DetailShrimpPriceEvent();

  @override
  List<Object?> get props => [];
}

class DetailShrimpPriceGetEvent extends DetailShrimpPriceEvent {
  final int id;
  final int? regionId;

  const DetailShrimpPriceGetEvent({required this.id, required this.regionId});

  @override
  List<Object?> get props => [id, regionId];
}
