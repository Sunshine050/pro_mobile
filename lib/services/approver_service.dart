// lib/services/approver_service.dart
import 'api_service.dart';

class ApproverService {
  final ApiService apiService = ApiService();

  Future<dynamic> getAllBookingRequests(String token) async {
    return await apiService.getRequest('/approver/booking-requests', headers: {'Authorization': 'Bearer $token'});
  }

  Future<dynamic> approveBooking(String bookingId, String token) async {
    return await apiService.postRequest('/approver/approve', {
      'id': bookingId,
    }, headers: {'Authorization': 'Bearer $token'});
  }

  Future<dynamic> rejectBooking(String bookingId, String token) async {
    return await apiService.postRequest('/approver/reject', {
      'id': bookingId,
    }, headers: {'Authorization': 'Bearer $token'});
  }
}
