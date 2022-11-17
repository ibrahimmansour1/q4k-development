import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class userProfile {
  String userId, name, email, image, department;
  FieldValue activeTime;
  double level;

  userProfile({
    required this.userId,
    required this.name,
    required this.email,
    required this.department,
    required this.image,
    required this.activeTime,
    required this.level,
  });

  factory userProfile.fromMap(Map<dynamic, dynamic> map) {
    return userProfile(
      userId: map['userId'],
      name: map['name'],
      email: map['email'],
      department: map['department'],
      image: map['image'],
      activeTime: map['activeTime'],
      level: map['level'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'department': department,
      'image': image,
      'activeTime': activeTime,
      'level': level,
    };
  }
}
