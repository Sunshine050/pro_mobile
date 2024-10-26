import 'api_service.dart';

class AuthService {
  final ApiService apiService = ApiService();

  String validateEmail(String email) {
    if (!email.contains('@')) {
      email += '@gmail.com';  
    }
    return email;
  }

  Future<dynamic> register(String username, String email, String password) async {
    final validatedEmail = validateEmail(email);
    return await apiService.postRequest('/api/auth/register', {
      'username': username,
      'email': validatedEmail,
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
