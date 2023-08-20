import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kr_paginate_firestore/paginate_firestore.dart';
import 'package:univastay/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Replace with the actual path

import 'package:univastay/models/models.dart';
import 'package:univastay/widgets/widgets.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen>
    with AutomaticKeepAliveClientMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize FirebaseAuth
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: ElevatedButton(
            onPressed: () async {
              await _auth.signOut(); // Sign out the user
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false, // Remove all previous routes
              );
            },
            child: Text('Logout'),
          ),
        ),
        Expanded(
          child: KrPaginateFirestore(
            itemBuilderType: PaginateBuilderType.listView,
            isLive: true,
            query: FirebaseFirestore.instance.collection(Hostel.directory),
            itemBuilder: (context, snapshot, index) {
              Hostel host = Hostel.fromSnapshot(snapshot[index]);

              return SingleHostel(
                hostel: host,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
