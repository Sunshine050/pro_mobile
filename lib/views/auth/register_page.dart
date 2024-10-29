import 'package:flutter/material.dart';
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

  String? role; // สร้างตัวแปรเพื่อเก็บ role

  void _register() {
    // ตรวจสอบอีเมลและกำหนด role
    String email = emailController.text.trim();

    if (email.endsWith('student@lamduan.mfu.ac.th')) {
      role = 'student';
    } else if (email.endsWith('staff@lamduan.mfu.ac.th')) {
      role = 'staff';
    } else if (email.endsWith('approver@lamduan.mfu.ac.th')) {
      role = 'approver';
    } else {
      // แสดงข้อความแจ้งเตือนถ้าอีเมลไม่ถูกต้อง
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email domain')),
      );
      return;
    }

    // แสดงข้อความแจ้งเตือนเมื่อการลงทะเบียนสำเร็จ
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registration successful!'),
        duration: Duration(seconds: 2), // ตั้งระยะเวลาในการแสดง SnackBar
      ),
    );

    // ใช้ Future.delayed เพื่อหน่วงเวลาการนำทางไปยังหน้าล็อกอิน
    Future.delayed(Duration(seconds: 2), () {
      // นำผู้ใช้ไปยังหน้า Login หลังจากลงทะเบียนสำเร็จ
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });
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
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
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
}
