part of 'shrimp_prices_cubit.dart';

class ShrimpPricesState extends Equatable {
  final List<ShrimpPriceEntity> shrimpPrices;
  final int? size;
  final int? regionId;
  final bool isLoading;
  final bool isError;
  final MetaDataApi? meta;

  const ShrimpPricesState({
    this.shrimpPrices = const [],
    this.size = 100,
    this.regionId,
    this.isLoading = false,
    this.isError = false,
    this.meta,
  });

  ShrimpPricesState copyWith({
    List<ShrimpPriceEntity>? shrimpPrices,
    int? size,
    int? regionId,
    bool? isLoading,
    bool? isError,
    MetaDataApi? meta,
  }) =>
      ShrimpPricesState(
        shrimpPrices: shrimpPrices ?? this.shrimpPrices,
        size: size ?? this.size,
        regionId: regionId ?? this.regionId,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        meta: meta ?? this.meta,
      );

  @override
  List<Object?> get props => [
        shrimpPrices,
        size,
        regionId,
        isLoading,
        isError,
        meta,
      ];
}
