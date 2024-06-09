part of 'shrimp_prices_cubit.dart';

class ShrimpPricesState extends Equatable {
  final List<ShrimpPriceEntity> shrimpPrices;
  final int? regionId;
  final bool isLoading;
  final bool isError;
  final MetaDataApi? meta;

  const ShrimpPricesState({
    this.shrimpPrices = const [],
    this.regionId,
    this.isLoading = false,
    this.isError = false,
    this.meta,
  });

  ShrimpPricesState copyWith({
    List<ShrimpPriceEntity>? shrimpPrices,
    int? regionId,
    bool? isLoading,
    bool? isError,
    MetaDataApi? meta,
  }) =>
      ShrimpPricesState(
        shrimpPrices: shrimpPrices ?? this.shrimpPrices,
        regionId: regionId ?? this.regionId,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        meta: meta ?? this.meta,
      );

  @override
  List<Object?> get props => [
        shrimpPrices,
        regionId,
        isLoading,
        isError,
        meta,
      ];
}
