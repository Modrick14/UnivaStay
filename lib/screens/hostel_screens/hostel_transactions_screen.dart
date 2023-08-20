import 'package:flutter/material.dart';
import 'package:univastay/screens/hostel_screens/hostel_chat_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_post_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_dashboard_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_home_screen.dart';

class HostelTransactionsScreen extends StatelessWidget {
  final String hostelId;

  HostelTransactionsScreen({required this.hostelId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Transactions'),
      ),
      body: Center(
        child: Text('Hostel Transactions Screen'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set the current index accordingly
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
                  builder: (context) => HostelHomeScreen(hostelId: hostelId),
                ),
              );
              break;
            case 2:
              // Navigate to hostel post screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HostelPostScreen(hostelId: hostelId),
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
            default:
              break;
          }
        },
      ),
    );
  }
}
