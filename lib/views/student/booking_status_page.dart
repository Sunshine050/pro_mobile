// lib/views/student/booking_status_page.dart
import 'package:flutter/material.dart';
import '../../models/booking_request.dart';
import '../../services/api_service.dart';

class BookingStatus extends StatefulWidget {
  @override
  _BookingStatusState createState() => _BookingStatusState();
}

class _BookingStatusState extends State<BookingStatus> {
  final ApiService apiService = ApiService();
  List<BookingRequest> bookingRequests = [];

  @override
  void initState() {
    super.initState();
    fetchBookingRequests();
  }

  Future<void> fetchBookingRequests() async {
    try {
      bookingRequests = await apiService.fetchBookingRequests();
      setState(() {});
    } catch (e) {
      print('Error fetching booking requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Status'),
      ),
      body: ListView.builder(
        itemCount: bookingRequests.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Request ID: ${bookingRequests[index].requestId}'),
            subtitle: Text('Status: ${bookingRequests[index].status}'),
          );
        },
      ),
    );
  }
}
