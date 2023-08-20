import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:univastay/screens/hostel_screens/hostel_chat_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_transactions_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_dashboard_screen.dart';
import 'package:univastay/screens/hostel_screens/hostel_home_screen.dart';

class HostelPostScreen extends StatelessWidget {
  final String hostelId;

  HostelPostScreen({required this.hostelId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Post'),
      ),
      body: HostelPostForm(hostelId: hostelId),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Set the current index accordingly
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

class HostelPostForm extends StatefulWidget {
  final String hostelId;

  HostelPostForm({required this.hostelId});

  @override
  _HostelPostFormState createState() => _HostelPostFormState();
}

class _HostelPostFormState extends State<HostelPostForm> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  List<PlatformFile> _mediaFiles = [];
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to handle adding media (photos)
  Future<void> _addMedia() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result != null) {
        List<PlatformFile> files = result.files;
        // For images, check the photo count
        if (files.isNotEmpty) {
          setState(() {
            _mediaFiles.addAll(files);
          });
        } else {
          // Invalid file type or maximum limit reached
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please select at least one photo.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      print('Error adding media: $e');
    }
  }

  // Function to handle the "Post" button click
  Future<void> _submitPost() async {
    // Get the input values from the controllers
    String title = _titleController.text;
    String description = _descriptionController.text;
    double price = double.tryParse(_priceController.text) ?? 0.0;

    try {
      if (_mediaFiles.isNotEmpty) {
        // Upload the media to Firebase Storage
        List<String> downloadUrls = [];
        for (var file in _mediaFiles) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference reference = _storage.ref().child('media/$fileName');
          UploadTask uploadTask = reference.putData(file.bytes!);
          TaskSnapshot taskSnapshot = await uploadTask;
          String downloadUrl = await taskSnapshot.ref.getDownloadURL();
          downloadUrls.add(downloadUrl);
        }

        // Upload the data to Firebase Firestore
        await _firestore
            .collection('hostels')
            .doc(widget.hostelId)
            .collection('posts')
            .add({
          'title': title,
          'description': description,
          'price': price,
          'mediaUrls': downloadUrls, // Store the media URLs in Firestore
        });

        // Show a snackbar to indicate successful posting
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Posted Successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Clear the form fields and media selection after posting
        _titleController.clear();
        _descriptionController.clear();
        _priceController.clear();
        setState(() {
          _mediaFiles.clear();
        });
      } else {
        // If no media is selected, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please add at least one photo.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error posting: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // Function to view and delete selected media (photos)
  Widget _buildMediaPreview() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _mediaFiles.asMap().entries.map((entry) {
          int index = entry.key;
          PlatformFile file = entry.value;
          return Stack(
            children: [
              Container(
                height: 150,
                width: 150,
                child: Image.memory(
                  file.bytes!,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  color: Colors.red,
                  onPressed: () {
                    // Remove the image from the selection
                    setState(() {
                      _mediaFiles.removeAt(index);
                    });
                  },
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title field
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16),

            // Description field
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16),

            // Price field
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
            SizedBox(height: 16),

            // Display selected media (if any)
            _mediaFiles.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Media',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildMediaPreview(),
                    ],
                  )
                : Container(),

            SizedBox(height: 16),

            // Add Media (Photos)
            ElevatedButton(
              onPressed: _addMedia,
              child: Text('Add Media'),
            ),
            SizedBox(height: 16),

            // Post button
            ElevatedButton(
              onPressed: _submitPost,
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
