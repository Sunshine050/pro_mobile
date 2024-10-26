// lib/models/booking_request.dart
class BookingRequest {
  final String requestId;
  final String status;

  BookingRequest({required this.requestId, required this.status});

  factory BookingRequest.fromJson(Map<String, dynamic> json) {
    return BookingRequest(
      requestId: json['requestId'],
      status: json['status'],
    );
  }
}
