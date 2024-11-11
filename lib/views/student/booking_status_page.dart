import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingStatus extends StatefulWidget {
  @override
  _BookingStatusPageState createState() => _BookingStatusPageState();
}

class _BookingStatusPageState extends State<BookingStatus> {
  String status = 'loading';
  List<dynamic> bookings = [];
  List<int> canceledBookings = [];

  @override
  void initState() {
    super.initState();
    _getBookings();
  }

  Future<String?> getTokenFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _getBookings() async {
    String? token = await getTokenFromStorage();

    if (token == null) {
      setState(() {
        status = 'error';
      });
      return;
    }

    final response = await http.get(
      Uri.parse('http://192.168.206.1:3000/student/bookings'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      setState(() {
        bookings = json.decode(response.body);
        status = bookings.isEmpty ? 'blank' : 'pending';
      });
    } else {
      setState(() {
        status = 'error';
      });
    }
  }

  Future<void> _cancelBooking(int bookingId) async {
    String? token = await getTokenFromStorage();
    if (token == null) return;

    final response = await http.put(
      Uri.parse('http://192.168.206.1:3000/student/cancel/$bookingId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print("Cancel Booking Response Status: ${response.statusCode}");
    print("Cancel Booking Response Body: ${response.body}");

    if (response.statusCode == 200) {
      setState(() {
        canceledBookings.add(bookingId);
        bookings.removeWhere((booking) => booking['id'] == bookingId);
        if (bookings.isEmpty) {
          status = 'blank';
        }
      });
    } else {
      print(
          "Error: Unable to cancel booking. Status code: ${response.statusCode}");
      setState(() {
        status = 'error';
      });
    }
  }

  Widget _buildPendingContent() {
    // Map สำหรับจับคู่ slot กับช่วงเวลา
    Map<String, String> slotTimes = {
      "slot_1": "08:00-10:00",
      "slot_2": "10:00-12:00",
      "slot_3": "13:00-15:00",
      "slot_4": "15:00-17:00"
    };

    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        var booking = bookings[index];
        String slot = booking['slot'] ?? 'No Slot';
        String bookingDate =
            booking['booking_date']?.split('T')[0] ?? 'No Date';

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    booking['roomImage'] ??
                        'https://library.mfu.ac.th/report-2565/wp-content/uploads/2023/04/DSC03294-1-edited-scaled.jpg',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  Text(
                    booking['room_name'] ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                      'Slot: ${slotTimes[slot] ?? slot}'), // แสดงช่วงเวลาตาม slot
                  SizedBox(height: 8),
                  Text('Booking Date: $bookingDate'), // แสดงเฉพาะวันที่
                  SizedBox(height: 8),
                  Text('Reason: ${booking['reason'] ?? 'No Reason'}'),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Status: '),
                      Text(
                        booking['status'] ?? 'No Status',
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
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
                        _showCancelConfirmationDialog(context, booking['id']);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showCancelConfirmationDialog(BuildContext context, int bookingId) {
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
                Navigator.of(context).pop();
                _cancelBooking(bookingId);
              },
              child: Text("Confirm", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Status'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: status == 'loading'
                  ? Center(child: CircularProgressIndicator())
                  : status == 'blank'
                      ? _buildBlankStatus()
                      : _buildPendingContent(),
            ),
          ),
        ],
      ),
    );
  }
}
