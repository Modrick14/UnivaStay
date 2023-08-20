import 'package:flutter/material.dart';
import 'package:univastay/constants/constants.dart';
import 'package:univastay/models/hostel.dart';

class HostelDetailsView extends StatefulWidget {
  final Hostel hostel;
  const HostelDetailsView({
    super.key,
    required this.hostel,
  });

  @override
  State<HostelDetailsView> createState() => _HostelDetailsViewState();
}

class _HostelDetailsViewState extends State<HostelDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            const CircleAvatar(
              radius: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 10,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: standardBorderRadius,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 10,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: standardBorderRadius,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(
                standardPadding,
              ),
              decoration: BoxDecoration(
                borderRadius: standardBorderRadius,
                color: primaryColor,
              ),
              width: double.infinity,
              child: Center(
                child: Text(
                  "Name: ${widget.hostel.name}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.category,
                  size: 50,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: standardBorderRadius,
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                children: [1, 2, 3, 4, 5, 6]
                    .map(
                      (e) => Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: standardBorderRadius,
                        ),
                        padding: const EdgeInsets.all(
                          standardPadding,
                        ),
                        child: const Icon(
                          Icons.image,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
