import 'package:equatable/equatable.dart';

class CreatorEntity extends Equatable {
  final int? id;
  final int? roleId;
  final String? name;
  final String? email;
  final bool? emailVerified;
  final String? avatar;
  final String? regionId;
  final String? address;
  final String? phone;
  final bool? phoneVerified;
  final bool? buyer;
  final String? genderName;
  final String? occupation;

  const CreatorEntity({
    this.id,
    this.roleId,
    this.name,
    this.email,
    this.emailVerified = false,
    this.avatar,
    this.regionId,
    this.address,
    this.phone,
    this.phoneVerified = false,
    this.buyer = false,
    this.genderName,
    this.occupation,
  });

  @override
  List<Object?> get props => [
        id,
        roleId,
        name,
        email,
        emailVerified,
        avatar,
        regionId,
        address,
        phone,
        phoneVerified,
        buyer,
        genderName,
        occupation,
      ];
}
