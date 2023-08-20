import 'package:flutter/material.dart';
import 'package:univastay/screens/hostel_screens/hostel_post_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_home_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_transactions_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_dashboard_screen.dart';

class HostelChatScreen extends StatelessWidget {
  final String hostelId;

  HostelChatScreen({required this.hostelId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Chat'),
      ),
      body: Center(
        child: Text('Hostel Chat Screen'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Set the current index accordingly
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
                  builder: (context) => HostelPostScreen(hostelId: hostelId),
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
