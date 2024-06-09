import 'package:equatable/equatable.dart';

import 'creator_entity.dart';
import 'region_entity.dart';

class ShrimpPriceEntity extends Equatable {
  final int? id;
  final int? speciesId;
  final String? date;
  final Map<String, dynamic> size;
  final String? countryId;
  final String? currencyId;
  final RegionEntity? region;
  final CreatorEntity? creator;

  const ShrimpPriceEntity(
      {required this.id,
      required this.speciesId,
      required this.date,
      required this.size,
      required this.countryId,
      required this.currencyId,
      required this.region,
      required this.creator});

  @override
  List<Object?> get props => [id, speciesId, date, size, countryId, currencyId, region, creator];
}
