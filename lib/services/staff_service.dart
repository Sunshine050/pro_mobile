// lib/services/staff_service.dart
import 'api_service.dart';

class StaffService {
  final ApiService apiService = ApiService();

  Future<dynamic> getAllRooms(String token) async {
    return await apiService.getRequest('/staff/rooms', headers: {'Authorization': 'Bearer $token'});
  }

  Future<dynamic> createRoom(Map<String, dynamic> roomData, String token) async {
    return await apiService.postRequest('/staff/room/create', roomData, headers: {'Authorization': 'Bearer $token'});
  }

  Future<dynamic> updateRoom(String roomId, Map<String, dynamic> roomData, String token) async {
    return await apiService.putRequest('/staff/room/update/$roomId', roomData, headers: {'Authorization': 'Bearer $token'});
  }

  Future<dynamic> deleteRoom(String roomId, String token) async {
    return await apiService.deleteRequest('/staff/room/delete/$roomId', headers: {'Authorization': 'Bearer $token'});
  }
}
