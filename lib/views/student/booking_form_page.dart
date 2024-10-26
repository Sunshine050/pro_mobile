import 'package:flutter/material.dart';

class BookingFormPage extends StatefulWidget {
  @override
  _BookingFormPageState createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeSlotController = TextEditingController();

  void _submitBooking() {
    // Submit booking logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book a Room')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: _timeSlotController,
              decoration: InputDecoration(labelText: 'Time Slot'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitBooking,
              child: Text('Submit Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
