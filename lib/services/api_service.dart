// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/room.dart';
import '../models/booking_request.dart';

class ApiService {
  final String baseUrl = 'YOUR_API_BASE_URL'; // แทนที่ด้วย URL ของ API ของคุณ

  Future<List<Room>> fetchRooms() async {
    final response = await http.get(Uri.parse('$baseUrl/rooms'));

    if (response.statusCode == 200) {
      List roomData = json.decode(response.body);
      return roomData.map((data) => Room.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  Future<List<BookingRequest>> fetchBookingRequests() async {
    final response = await http.get(Uri.parse('$baseUrl/booking_requests'));

    if (response.statusCode == 200) {
      List requestData = json.decode(response.body);
      return requestData.map((data) => BookingRequest.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load booking requests');
    }
  }
}
