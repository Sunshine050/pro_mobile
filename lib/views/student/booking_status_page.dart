import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingStatus extends StatefulWidget {
  @override
  _BookingStatusPageState createState() => _BookingStatusPageState();
}

class _BookingStatusPageState extends State<BookingStatus> {
  String status = 'loading'; // เปลี่ยนสถานะเริ่มต้นเป็น 'loading' ก่อนดึงข้อมูล
  List<dynamic> bookings = [];
  List<int> canceledBookings = []; // ใช้เก็บ ID ของการจองที่ยกเลิกแล้ว

  @override
  void initState() {
    super.initState();
    _getBookings(); // เรียกฟังก์ชันดึงข้อมูลเมื่อเริ่มต้น
  }

  // ฟังก์ชันในการดึง token จาก local storage
  Future<String?> getTokenFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _getBookings() async {
    // ดึง token จาก local storage
    String? token = await getTokenFromStorage();

    // ถ้าไม่มี token ให้แสดงข้อความเตือนหรือทำการล็อกอินใหม่
    if (token == null) {
      setState(() {
        status = 'error'; // แสดงข้อผิดพลาดหากไม่มี token
      });
      return;
    }

    final response = await http.get(
      Uri.parse('http://192.168.206.1:3000/student/bookings'),
      headers: {
        'Authorization': 'Bearer $token', // ส่ง token ใน header
      },
    );

    print("Response Status: ${response.statusCode}"); // ดูสถานะการตอบกลับ
    print("Response Body: ${response.body}"); // ดูข้อมูลที่ได้รับจาก API

    if (response.statusCode == 200) {
      setState(() {
        bookings = json.decode(response.body); // แปลงข้อมูล JSON เป็น List
        status = bookings.isEmpty
            ? 'blank'
            : 'pending'; // ถ้าไม่มีการจองให้แสดงสถานะ 'blank'
      });
    } else {
      setState(() {
        status = 'error'; // ถ้ามีข้อผิดพลาดในการดึงข้อมูล
      });
    }
  }

  // ฟังก์ชันยกเลิกการจอง
  Future<void> _cancelBooking(int bookingId) async {
    String? token = await getTokenFromStorage();
    if (token == null) return;

    final response = await http.put(
      Uri.parse(
          'http://192.168.206.1:3000/student/cancel/$bookingId'), // เปลี่ยนคำว่า 'cancle' เป็น 'cancel'
      headers: {
        'Authorization': 'Bearer $token', // ส่ง token ใน header
      },
    );

    // พิมพ์สถานะการตอบกลับและข้อมูลจาก API
    print("Cancel Booking Response Status: ${response.statusCode}");
    print("Cancel Booking Response Body: ${response.body}");

    if (response.statusCode == 200) {
      setState(() {
        canceledBookings.add(bookingId); // เพิ่ม ID การจองที่ยกเลิกแล้ว
        bookings.removeWhere((booking) =>
            booking['id'] == bookingId); // ลบการจองที่ยกเลิกจากรายการ
        if (bookings.isEmpty) {
          status = 'blank'; // ถ้าจองหมดแล้วแสดงสถานะเป็น blank
        }
      });
    } else {
      // เพิ่มการพิมพ์สำหรับข้อผิดพลาดต่าง ๆ ที่เกิดขึ้น
      print(
          "Error: Unable to cancel booking. Status code: ${response.statusCode}");
      setState(() {
        status = 'error'; // ถ้ามีข้อผิดพลาดในการยกเลิกการจอง
      });
    }
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

  // หน้าจอเมื่อสถานะเป็น 'pending'
  Widget _buildPendingContent() {
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        var booking = bookings[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // เพิ่มภาพห้องที่นี่
                  Image.network(
                    booking['roomImage'] ??
                        'https://library.mfu.ac.th/report-2565/wp-content/uploads/2023/04/DSC03294-1-edited-scaled.jpg', // ใช้ URL placeholder ถ้า 'roomImage' เป็น null
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  SizedBox(height: 8),
                  Text(
                    booking['room_name'] ??
                        '', // ใช้ข้อความ default ถ้า 'room_name' เป็น null
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Slot: ${booking['slot'] ?? 'No Slot'}'),
                  SizedBox(height: 8),
                  Text('Booking Date: ${booking['booking_date'] ?? 'No Date'}'),
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

  // ฟังก์ชันแสดง dialog ยืนยันการยกเลิก
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
                // ปิด dialog และยกเลิกการจอง
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

  // หน้าจอเมื่อสถานะเป็น 'blank'
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
