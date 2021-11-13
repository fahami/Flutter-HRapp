import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final DateTime? dateCreated;
  final DateTime? dateUpdated;
  final String? fullname;
  final String? phone;
  final String? email;
  final dynamic address;
  final dynamic type;
  final List? userExperiences;
  final List? userEducations;

  const User({
    this.id,
    this.dateCreated,
    this.dateUpdated,
    this.fullname,
    this.phone,
    this.email,
    this.address,
    this.type,
    this.userExperiences,
    this.userEducations,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        dateCreated: json['date_created'] == null
            ? null
            : DateTime.parse(json['date_created'] as String),
        dateUpdated: json['date_updated'] == null
            ? null
            : DateTime.parse(json['date_updated'] as String),
        fullname: json['fullname'] == null ? null : json['fullname'] as String?,
        phone: json['phone'] == null ? null : json['phone'] as String?,
        email: json['email'] == null ? null : json['email'] as String?,
        address: json['address'] == null ? null : json['address'] as dynamic?,
        type: json['type'] == null ? null : json['type'] as dynamic?,
        userExperiences: json['user_experiences'] as List?,
        userEducations: json['user_educations'] as List?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date_created': dateCreated?.toIso8601String(),
        'date_updated': dateUpdated?.toIso8601String(),
        'fullname': fullname,
        'phone': phone,
        'email': email,
        'address': address,
        'type': type,
        'user_experiences': userExperiences,
        'user_educations': userEducations,
      };

  @override
  List<Object?> get props {
    return [
      id,
      dateCreated,
      dateUpdated,
      fullname,
      phone,
      email,
      address,
      type,
      userExperiences,
      userEducations,
    ];
  }
}
