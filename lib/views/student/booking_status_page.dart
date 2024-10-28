import 'package:flutter/material.dart';

class BookingStatus extends StatefulWidget {
  @override
  _BookingStatusPageState createState() => _BookingStatusPageState();
}

class _BookingStatusPageState extends State<BookingStatus> {
  String status = 'panding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child:
              status == 'blank' ? _buildBlankStatus() : _buildPendingContent(),
        ),
      ),
    );
  }

  Widget _buildPendingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          'https://library.mfu.ac.th/report-2565/wp-content/uploads/2023/04/DSC03294-1-edited-scaled.jpg',
          height: 120,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Room Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/icon2/hour-glass.png',
              width: 50,
              height: 50,
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Subtitle',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 8),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 8),
        Text('Selected time slot: 08:00 - 10:00'),
        SizedBox(height: 8),
        Row(
          children: [
            Text('Status: '),
            Text(
              'Pending',
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              _showCancelConfirmationDialog(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void _showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Row(
            children: [
              Icon(Icons.info, color: Colors.black),
              SizedBox(width: 8),
              Text("Notification"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 253, 252, 252),
                ),
                padding: EdgeInsets.all(16),
                child: Image.asset(
                  'assets/icon2/remove.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 16),
              Text("Are you sure you want to cancel this reservation?"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // ปิด dialog และเปลี่ยนสถานะเป็น 'blank'
                Navigator.of(context).pop();
                setState(() {
                  status = 'blank';
                });
              },
              child: Text("confirm", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

//------------------------------blank-------------------------//
  Widget _buildBlankStatus() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.edit_off,
          color: Colors.grey,
          size: 80,
        ),
        SizedBox(height: 16),
        Text(
          'No pending requests.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
