// lib/services/auth_service.dart
import 'api_service.dart';

class AuthService {
  final ApiService apiService = ApiService();

  Future<dynamic> register(String username, String password) async {
    return await apiService.postRequest('/api/auth/register', {
      'username': username,
      'password': password,
    });
  }

  Future<dynamic> login(String username, String password) async {
    return await apiService.postRequest('/api/auth/login', {
      'username': username,
      'password': password,
    });
  }

  Future<dynamic> getAllUsers(String token) async {
    return await apiService.getRequest('/api/auth/users', headers: {'Authorization': 'Bearer $token'});
  }
}
