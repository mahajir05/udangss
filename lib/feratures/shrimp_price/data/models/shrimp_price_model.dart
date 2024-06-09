import '../../domain/entities/shrimp_price_entity.dart';
import 'creator_model.dart';
import 'region_model.dart';

class ShrimpPriceModel extends ShrimpPriceEntity {
  const ShrimpPriceModel(
      {required super.id,
      required super.speciesId,
      required super.date,
      required super.size,
      required super.countryId,
      required super.currencyId,
      required super.region,
      required super.creator});

  static ShrimpPriceModel fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> size = {};
    for (var element in json.keys) {
      if (element.startsWith("size_")) {
        size[element] = json[element];
      }
    }
    return ShrimpPriceModel(
      id: json['id'],
      speciesId: json['species_id'],
      date: json['date'],
      size: size,
      countryId: json['country_id'],
      currencyId: json['currency_id'],
      region: json['region'] != null ? RegionModel.fromJson(json['region']) : null,
      creator: json['creator'] != null ? CreatorModel.fromJson(json['creator']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['species_id'] = speciesId;
    data['date'] = date;
    size.forEach((key, value) {
      data[key] = value;
    });
    data['country_id'] = countryId;
    data['currency_id'] = currencyId;
    // data['region'] = RegionModel;
    // data['creator'] = provinceId;
    return data;
  }
}
