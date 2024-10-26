import 'api_service.dart';

class StudentService {
  final ApiService apiService = ApiService();

  Future<dynamic> bookRoom(Map<String, dynamic> bookingData) async {
    return await apiService.postRequest('/student/book', bookingData);
  }

  Future<dynamic> getUserBookings(String userId) async {
    return await apiService.getRequest('/student/bookings/$userId');
  }
}
