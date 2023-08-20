import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Hostel {
  final String name;
  final String location;
  final double prizeRange; // You can change the type as needed

  Hostel({
    required this.name,
    required this.location,
    required this.prizeRange,
  });
  factory Hostel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Hostel(
        name: data['name'],
        location: data['location'],
        prizeRange: data['prizeRange']);
  }
}
