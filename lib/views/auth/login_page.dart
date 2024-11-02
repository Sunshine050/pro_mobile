import 'package:flutter/material.dart';
import 'package:pro_mobile/views/auth/register_page.dart';
import 'package:pro_mobile/views/browse.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignInPressed() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();

      // ตรวจสอบประเภทผู้ใช้จากอีเมล
      String? role = _getRoleFromEmail(username);
      if (role == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email domain')),
        );
        return;
      }

      // ตรวจสอบรหัสผ่าน
      if (!_isPasswordValid(role, password)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Incorrect password')),
        );
        return;
      }

      // นำไปยัง RoomListPage เมื่อเข้าสู่ระบบสำเร็จ
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Browse(role: role),
        ),
      );
    }
  }

  String? _getRoleFromEmail(String email) {
    if (email.endsWith('student@lamduan.mfu.ac.th')) {
      return 'student';
    } else if (email.endsWith('staff@lamduan.mfu.ac.th')) {
      return 'staff';
    } else if (email.endsWith('approver@lamduan.mfu.ac.th')) {
      return 'approver';
    }
    return null; // อีเมลไม่ถูกต้อง
  }

  bool _isPasswordValid(String role, String password) {
    // ตรวจสอบรหัสผ่านตามบทบาท
    switch (role) {
      case 'student':
        return password == 'studentPassword'; // เปลี่ยนรหัสผ่านสำหรับนักเรียน
      case 'staff':
        return password == 'staffPassword'; // เปลี่ยนรหัสผ่านสำหรับเจ้าหน้าที่
      case 'approver':
        return password == 'approverPassword'; // เปลี่ยนรหัสผ่านสำหรับผู้อนุมัติ
      default:
        return false; // ถ้า role ไม่ถูกต้อง
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    'Log In',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _onSignInPressed,
                    child: const Text('SIGN IN'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('New Member?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()),
                          );
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
