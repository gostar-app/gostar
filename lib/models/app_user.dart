// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Appuser {
  final String name;
  final String email;
  final String city;
  final String phoneNo;
  final String profileImg;

  const Appuser({
    required this.name,
    required this.email,
    required this.city,
    required this.phoneNo,
    required this.profileImg,
  });

  Appuser copyWith({
    String? name,
    String? email,
    String? city,
    String? phoneNo,
    String? profileImg,
  }) {
    return Appuser(
      name: name ?? this.name,
      email: email ?? this.email,
      city: city ?? this.city,
      phoneNo: phoneNo ?? this.phoneNo,
      profileImg: profileImg ?? this.profileImg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'city': city,
      'phoneNo': phoneNo,
      'profileImg': profileImg,
    };
  }

  factory Appuser.fromMap(Map<String, dynamic> map) {
    return Appuser(
      name: map['name'] as String,
      email: map['email'] as String,
      city: map['city'] as String,
      phoneNo: map['phoneNo'] as String,
      profileImg: map['profileImg'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Appuser.fromJson(String source) =>
      Appuser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Driver(name: $name, email: $email, city: $city, phoneNo: $phoneNo, profileImg: $profileImg)';
  }

  @override
  bool operator ==(covariant Appuser other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.city == city &&
        other.phoneNo == phoneNo &&
        other.profileImg == profileImg;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        city.hashCode ^
        phoneNo.hashCode ^
        profileImg.hashCode;
  }
}
