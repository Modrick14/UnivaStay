import 'package:flutter/material.dart';

class UserChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Chat'),
      ),
      body: Center(
        child: Text('User Chat Screen Content'),
      ),
      // Use the user navigation bar here
    );
  }
}
