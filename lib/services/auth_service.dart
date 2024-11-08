import 'api_service.dart';

class AuthService {
  final ApiService apiService = ApiService();

  // เพิ่มเติม: ฟังก์ชัน validateEmail
  String validateEmail(String email) {
    if (!email.contains('@')) {
      email += '@lamduan.mfu.ac.th';
    }
    return email;
  }

  // ฟังก์ชัน register สำหรับการลงทะเบียน
  Future<dynamic> register(
      String username, String email, String password) async {
    final validatedEmail = validateEmail(email);
    final response = await apiService.postRequest(
      'http://192.168.1.7:3000/student/api/auth/register',
      {
        'username': username,
        'email': validatedEmail,
        'password': password,
      },
    );
    return response;
  }

  // ฟังก์ชัน login สำหรับการเข้าสู่ระบบ
  Future<dynamic> login(String username, String password) async {
    final response = await apiService.postRequest(
      'http://192.168.1.7:3000/student/api/auth/login',
      {
        'username': username,
        'password': password,
      },
    );
    return response;
  }

  // ฟังก์ชัน getAllUsers สำหรับดึงข้อมูลผู้ใช้ทั้งหมด โดยใช้ token
  Future<dynamic> getAllUsers(String token) async {
    final response = await apiService.getRequest(
      'http://192.168.1.7:3000/student/api/auth/users',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }
}
