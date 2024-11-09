import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pro_mobile/services/auth_service.dart';
import 'package:pro_mobile/views/auth/login_page.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final AuthService authService = AuthService(); // สร้างตัวแปร AuthService

  // ฟังก์ชันการลงทะเบียน
  void _register() async {
    String email = emailController.text.trim();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // ตรวจสอบความถูกต้องของรหัสผ่าน
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      // เรียกใช้งานฟังก์ชันการลงทะเบียน
      final response =
          await authService.register(username, email, password).timeout(
                const Duration(seconds: 10),
              );

      // ตรวจสอบการตอบกลับจาก API
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> res = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res['message']), // แสดงข้อความจาก response
            duration: const Duration(seconds: 2),
          ),
        );
        // นำทางไปยังหน้า Login หลังจากลงทะเบียนสำเร็จ
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        });
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Register',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // ฟอร์มกรอกข้อมูล
              _buildTextField(
                  emailController, 'Email', TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildTextField(
                  usernameController, 'Username', TextInputType.text),
              const SizedBox(height: 16),
              _buildTextField(
                  passwordController, 'Password', TextInputType.text,
                  obscureText: true),
              const SizedBox(height: 16),
              _buildTextField(confirmPasswordController, 'Confirm Password',
                  TextInputType.text,
                  obscureText: true),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // กลับไปที่หน้าล็อกอิน
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // สร้างฟังก์ชัน TextField เพื่อทำให้โค้ดสะดวกในการใช้งาน
  Widget _buildTextField(TextEditingController controller, String label,
      TextInputType keyboardType,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
