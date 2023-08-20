import 'package:flutter/material.dart';
import 'package:univastay/constants/constants.dart';
import 'package:univastay/models/hostel.dart';
import 'package:univastay/services/navigation.dart';

import 'package:univastay/screens/hostel_details_view.dart';

class SingleHostel extends StatelessWidget {
  final Hostel hostel;
  const SingleHostel({
    super.key,
    required this.hostel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService().push(
          HostelDetailsView(
            hostel: hostel,
          ),
        );
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(
          horizontal: standardPadding / 2,
          vertical: standardPadding / 2,
        ),
        padding: const EdgeInsets.all(
          standardPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: standardBorderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: standardBorderRadius,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  hostel.name,
                ),
                Text(
                  hostel.location,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
