// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final List<String> userFavor;
  final List<String> userStudy;
  final String createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.userFavor,
    required this.userStudy,
    required this.createdAt,
  });

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final usersData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      name: usersData!['name'],
      email: usersData['email'],
      profileImage: usersData['profileImage'],
      userFavor: usersData['userFavor'],
      userStudy: usersData['userStudy'],
      createdAt: usersData['createdAt'],
    );
  }

  factory User.initialUser() {
    return User(
      id: '',
      name: '',
      email: '',
      profileImage: '',
      userFavor: [],
      userStudy: [],
      createdAt: '',
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      profileImage,
      userFavor,
      userStudy,
      createdAt,
    ];
  }
}
