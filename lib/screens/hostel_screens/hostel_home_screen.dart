import 'package:flutter/material.dart';
import 'package:univastay/screens/hostel_screens/hostel_post_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_chat_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_transactions_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_dashboard_screen.dart';

class HostelHomeScreen extends StatelessWidget {
  final String hostelId;

  HostelHomeScreen({required this.hostelId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Home'),
      ),
      body: Column(
        children: [
          // Search bar
          // Add your search bar widget here

          // Hostel Feed
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with the actual number of hostel posts
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the analytics page for the selected post
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => AnalyticsPage(),
                    //   ),
                    // );
                  },
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                          // Replace with the post's profile picture
                          // backgroundImage: AssetImage('assets/default_profile.jpg'),
                          ),
                      title: Text('Post Title'), // Replace with the post title
                      subtitle: Text(
                          'Post Description'), // Replace with the post description
                      trailing: IconButton(
                        icon: Icon(
                          Icons.analytics,
                        ), // Replace with the analytics icon
                        onPressed: () {
                          // Navigate to the analytics page for the selected post
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => AnalyticsPage(),
                          //   ),
                          // );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Recent Visitors Bar
          // Add your recent visitors bar widget here
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set the current index accordingly
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
              break;
            case 1:
              // Navigate to hostel transactions screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HostelTransactionsScreen(hostelId: hostelId),
                ),
              );
              break;
            case 2:
              // Navigate to hostel post screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HostelPostScreen(
                      hostelId: hostelId), // Pass the hostelId here
                ),
              );
              break;
            case 3:
              // Navigate to hostel chat screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HostelChatScreen(hostelId: hostelId),
                ),
              );
              break;
            case 4:
              // Navigate to hostel dashboard screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HostelDashboardScreen(hostelId: hostelId),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
