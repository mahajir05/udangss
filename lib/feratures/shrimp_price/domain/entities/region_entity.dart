import 'package:equatable/equatable.dart';

class RegionEntity extends Equatable {
  final String? id;
  final String? name;
  final int? type;
  final String? latitude;
  final String? longitude;
  final String? countryId;
  final String? countryName;
  final String? countryNameUppercase;
  final String? provinceId;
  final String? provinceName;
  final String? regencyId;
  final String? regencyName;
  final String? districtId;
  final String? districtName;
  final String? villageId;
  final String? villageName;
  final String? fullName;
  final String? nameTranslated;
  final String? countryNameTranslated;
  final String? countryNameTranslatedUppercase;

  const RegionEntity(
      {this.id,
      this.name,
      this.type,
      this.latitude,
      this.longitude,
      this.countryId,
      this.countryName,
      this.countryNameUppercase,
      this.provinceId,
      this.provinceName,
      this.regencyId,
      this.regencyName,
      this.districtId,
      this.districtName,
      this.villageId,
      this.villageName,
      this.fullName,
      this.nameTranslated,
      this.countryNameTranslated,
      this.countryNameTranslatedUppercase});

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        latitude,
        longitude,
        countryId,
        countryName,
        countryNameUppercase,
        provinceId,
        provinceName,
        regencyId,
        regencyName,
        districtId,
        districtName,
        villageId,
        villageName,
        fullName,
        nameTranslated,
        countryNameTranslated,
        countryNameTranslatedUppercase,
      ];
}
