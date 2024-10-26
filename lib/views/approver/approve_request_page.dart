import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/booking_request.dart';

class ApproveRequests extends StatefulWidget {
  @override
  _ApproveRequestsState createState() => _ApproveRequestsState();
}

class _ApproveRequestsState extends State<ApproveRequests> {
  ApiService apiService = ApiService();
  List<BookingRequest> bookingRequests = [];

  @override
  void initState() {
    super.initState();
    fetchBookingRequests();
  }

  void fetchBookingRequests() async {
    try {
      List requestData = await apiService.fetchBookingRequests();
      setState(() {
        bookingRequests = requestData.map((data) => BookingRequest.fromJson(data)).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load booking requests: $e')),
      );
    }
  }

  void approveRequest(String requestId) async {
    try {
      await apiService.approveRequest(requestId);
      fetchBookingRequests(); // Refresh the list after approval
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to approve request: $e')),
      );
    }
  }

  void rejectRequest(String requestId) async {
    try {
      await apiService.rejectRequest(requestId);
      fetchBookingRequests(); // Refresh the list after rejection
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reject request: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approve Requests'),
      ),
      body: bookingRequests.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: bookingRequests.length,
              itemBuilder: (context, index) {
                final request = bookingRequests[index];
                return ListTile(
                  title: Text('Room: ${request.roomId}'),
                  subtitle: Text('Date: ${request.date} - Time: ${request.timeSlot}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          approveRequest(request.id); // use request.id instead of request.roomId
                        },
                        child: Text('Approve'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          rejectRequest(request.id); // use request.id instead of request.roomId
                        },
                        child: Text('Reject'),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
