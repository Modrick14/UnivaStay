import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPostScreen extends StatefulWidget {
  final String hostelId;
  final String postId;

  EditPostScreen({required this.hostelId, required this.postId});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  Map<String, dynamic> postData = {}; // Initialize postData with an empty map

  @override
  void initState() {
    super.initState();
    fetchPostData();
  }

  // Function to fetch post data from Firestore
  void fetchPostData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('hostels')
          .doc(widget.hostelId)
          .collection('posts')
          .doc(widget.postId)
          .get();

      setState(() {
        postData = snapshot.data() as Map<String, dynamic>;
      });
    } catch (e) {
      print('Error fetching post data: $e');
      // Handle the error here, e.g., show an error message to the user
    }
  }

  void _updatePostData() async {
    try {
      await FirebaseFirestore.instance
          .collection('hostels')
          .doc(widget.hostelId)
          .collection('posts')
          .doc(widget.postId)
          .update(postData);

      Navigator.pop(context); // Go back to the dashboard screen after update
    } catch (e) {
      print('Error updating post data: $e');
      // Handle the error here, e.g., show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display post data for editing (e.g., text fields, image/video preview)
            // For example:
            TextFormField(
              initialValue: postData['title'] as String? ?? '',
              onChanged: (value) {
                setState(() {
                  postData['title'] = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updatePostData,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
