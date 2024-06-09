import '../../domain/entities/region_entity.dart';

class RegionModel extends RegionEntity {
  const RegionModel({
    super.id,
    super.name,
    super.type,
    super.latitude,
    super.longitude,
    super.countryId,
    super.countryName,
    super.countryNameUppercase,
    super.provinceId,
    super.provinceName,
    super.regencyId,
    super.regencyName,
    super.districtId,
    super.districtName,
    super.villageId,
    super.villageName,
    super.fullName,
    super.nameTranslated,
    super.countryNameTranslated,
    super.countryNameTranslatedUppercase,
  });

  static RegionModel fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      countryId: json['country_id'],
      countryName: json['country_name'],
      countryNameUppercase: json['country_name_uppercase'],
      provinceId: json['province_id'],
      provinceName: json['province_name'],
      regencyId: json['regency_id'],
      regencyName: json['regency_name'],
      districtId: json['district_id'],
      districtName: json['district_name'],
      villageId: json['village_id'],
      villageName: json['village_name'],
      fullName: json['full_name'],
      nameTranslated: json['name_translated'],
      countryNameTranslated: json['country_name_translated'],
      countryNameTranslatedUppercase: json['country_name_translated_uppercase'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['country_id'] = countryId;
    data['country_name'] = countryName;
    data['country_name_uppercase'] = countryNameUppercase;
    data['province_id'] = provinceId;
    data['province_name'] = provinceName;
    data['regency_id'] = regencyId;
    data['regency_name'] = regencyName;
    data['district_id'] = districtId;
    data['district_name'] = districtName;
    data['village_id'] = villageId;
    data['village_name'] = villageName;
    data['full_name'] = fullName;
    data['name_translated'] = nameTranslated;
    data['country_name_translated'] = countryNameTranslated;
    data['country_name_translated_uppercase'] = countryNameTranslatedUppercase;
    return data;
  }
}
