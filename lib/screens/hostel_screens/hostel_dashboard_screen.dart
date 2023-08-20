import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:univastay/screens/hostel_screens/hostel_chat_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_transactions_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_post_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_home_screen.dart';
import 'package:univastay/screens/hostel_screens/edit_post_screen.dart';
import 'package:univastay/screens/hostel_screens/edit_profile_screen.dart';

class HostelDashboardScreen extends StatefulWidget {
  final String hostelId;

  HostelDashboardScreen({required this.hostelId});

  @override
  _HostelDashboardScreenState createState() => _HostelDashboardScreenState();
}

class _HostelDashboardScreenState extends State<HostelDashboardScreen> {
  late Map<String, dynamic> hostelData;
  late List<dynamic> hostelPosts;

  @override
  void initState() {
    super.initState();
    fetchHostelData();
    fetchHostelPosts();
  }

  void fetchHostelData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('hostels')
          .doc(widget.hostelId)
          .get();
      setState(() {
        hostelData = snapshot.data() as Map<String, dynamic>;
      });
    } catch (e) {
      print('Error fetching hostel data: $e');
    }
  }

  void fetchHostelPosts() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('hostels')
          .doc(widget.hostelId)
          .collection('posts')
          .get();
      setState(() {
        hostelPosts = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print('Error fetching hostel posts: $e');
    }
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Display full-screen profile picture when tapped
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    child: CircleAvatar(
                      radius: 120,
                      backgroundImage: hostelData['profilePictureUrl'] != null
                          ? NetworkImage(
                              hostelData['profilePictureUrl'] as String)
                          : AssetImage('assets/default_profile.png')
                              as ImageProvider<Object>,
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 80,
                backgroundImage: hostelData['profilePictureUrl'] != null
                    ? NetworkImage(hostelData['profilePictureUrl'] as String)
                    : AssetImage('assets/default_profile.png')
                        as ImageProvider<Object>,
              ),
            ),
            SizedBox(height: 16),
            Text(
              hostelData['hostelName'] as String? ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                        hostelId: widget.hostelId, hostelData: hostelData),
                  ),
                );
              },
              child: Text('Edit Profile'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: hostelPosts.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: hostelPosts.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> post = hostelPosts[index];
                        List<dynamic> mediaUrls =
                            post['mediaUrls'] as List<dynamic>;
                        String firstMediaUrl = mediaUrls.isNotEmpty
                            ? mediaUrls[0] as String
                            : 'https://via.placeholder.com/150'; // Replace with a placeholder image URL
                        String postId = post['postId'] as String? ?? '';
                        return GestureDetector(
                          onTap: () {
                            // Navigate to edit post screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPostScreen(
                                  hostelId: widget.hostelId,
                                  postId: postId,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(firstMediaUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No Hostel Posts Available',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4, // Set the current index accordingly
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
        onTap: (index) {
          // Handle navigation to other screens here
          switch (index) {
            case 0:
              // Navigate to hostel home screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HostelHomeScreen(hostelId: widget.hostelId),
                ),
              );
              break;
            case 1:
              // Navigate to hostel transactions screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HostelTransactionsScreen(hostelId: widget.hostelId),
                ),
              );
              break;
            case 2:
              // Navigate to hostel post screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HostelPostScreen(hostelId: widget.hostelId),
                ),
              );
              break;
            case 3:
              // Navigate to hostel chat screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HostelChatScreen(hostelId: widget.hostelId),
                ),
              );
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
