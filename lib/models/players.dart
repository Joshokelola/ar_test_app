import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String userName;
  final String fullName;
  final String email;
  final int points;
  final List<String> collectedArtifacts;
  final Map<String, dynamic> otherData;

  User({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.points,
    required this.userName,
    required this.collectedArtifacts,
    required this.otherData,
  });

  // Create a User object from Firestore document
  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      points: data['points'] ?? 0,
      collectedArtifacts: List<String>.from(data['collectedArtifacts'] ?? []),
      otherData: data['otherData'] ?? {},
      userName: data['userName'] ?? '',
    );
  }

  // Convert User object to Firestore document data
  Map<String, dynamic> toDocument() {
    return {
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'points': points,
      'collectedArtifacts': collectedArtifacts,
      'otherData': otherData,
    };
  }
}
