import '../../domain/entities/creator_entity.dart';

class CreatorModel extends CreatorEntity {
  const CreatorModel({
    super.id,
    super.roleId,
    super.name,
    super.email,
    super.emailVerified = false,
    super.avatar,
    super.regionId,
    super.address,
    super.phone,
    super.phoneVerified,
    super.buyer = false,
    super.genderName,
    super.occupation,
  });

  static CreatorModel fromJson(Map<String, dynamic> json) {
    return CreatorModel(
      id: json['id'],
      roleId: json['role_id'],
      name: json['name'],
      email: json['email'],
      emailVerified: json['email_verified'],
      avatar: json['avatar'],
      regionId: json['region_id'],
      address: json['address'],
      phone: json['phone'],
      phoneVerified: json['phone_verified'],
      buyer: json['buyer'],
      genderName: json['gender_name'],
      occupation: json['occupation'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role_id'] = roleId;
    data['name'] = name;
    data['email'] = email;
    data['email_verified'] = emailVerified;
    data['avatar'] = avatar;
    data['region_id'] = regionId;
    data['address'] = address;
    data['phone'] = phone;
    data['phone_verified'] = phoneVerified;
    data['buyer'] = buyer;
    data['gender_name'] = genderName;
    data['occupation'] = occupation;
    return data;
  }
}
