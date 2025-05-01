// User model remains the same
import 'package:drift/drift.dart';

import '../../../../database/local_database.dart';


class User {
  final String id;
  final String email;
  final Profile? profile;

  User({required this.id, required this.email, this.profile});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
    );
  }

  // Add this for Drift compatibility
  factory User.fromData(UsersCompanion data, {Profile? profile}) {
    return User(
      id: data.id.value,
      email: data.email.value,
      profile: profile,
    );
  }

  UsersCompanion toUserCompanion() => UsersCompanion(
    id: Value(id),
    email: Value(email),
  );
}

// Profile model (updated for Drift)
class Profile {
  final String userId; // Matches Profiles.userId
  final String? name;
  final String? phoneNumber;
  final String? address;
  final String? profilePictureUrl;
  final DateTime createdAt; // Optional field
  final DateTime updatedAt; // Optional field

  Profile({
    required this.userId,
    this.name,
    this.phoneNumber,
    this.address,
    this.profilePictureUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userId: json['user_id'], // Must match the user's ID
      name: json['name'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      profilePictureUrl: json['profile_picture_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),  
    );
  }

  ProfilesCompanion toProfileCompanion() => ProfilesCompanion(
    userId: Value(userId),
    name: Value(name),
    phoneNumber: Value(phoneNumber),
    address: Value(address),
    profilePictureUrl: Value(profilePictureUrl),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
  );
}