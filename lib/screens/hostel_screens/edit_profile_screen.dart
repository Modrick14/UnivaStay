import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  final String hostelId;
  final Map<String, dynamic> hostelData;

  EditProfileScreen({required this.hostelId, required this.hostelData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Text('Edit Profile Screen'),
      ),
    );
  }
}
