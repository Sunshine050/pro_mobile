import 'package:flutter/material.dart';
import 'package:pro_mobile/views/auth/register_page.dart';
import 'package:pro_mobile/widgets/browse.dart';

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
      String username = _usernameController.text;
      String password = _passwordController.text;

      // ตรวจสอบประเภทผู้ใช้จากอีเมล
      String role;
      if (username.endsWith('student@lamduan.mfu.ac.th')) {
        role = 'student';
      } else if (username.endsWith('staff@lamduan.mfu.ac.th')) {
        role = 'staff';
      } else if (username.endsWith('approver@lamduan.mfu.ac.th')) {
        role = 'approver';
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email domain')),
        );
        print('Login failed: Invalid email domain for $username');
        return;
      }

      // ตรวจสอบรหัสผ่านแบบ hardcoded
      String expectedPassword;

      // กำหนดรหัสผ่านตามบทบาท
      if (role == 'student') {
        expectedPassword =
            'studentPassword'; // เปลี่ยนเป็นรหัสผ่านที่ต้องการสำหรับนักเรียน
      } else if (role == 'staff') {
        expectedPassword =
            'staffPassword'; // เปลี่ยนเป็นรหัสผ่านที่ต้องการสำหรับเจ้าหน้าที่
      } else if (role == 'approver') {
        expectedPassword =
            'approverPassword'; // เปลี่ยนเป็นรหัสผ่านที่ต้องการสำหรับผู้อนุมัติ
      } else {
        // ถ้า role ไม่ถูกต้อง
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Role not recognized')),
        );
        return;
      }

      // ตรวจสอบรหัสผ่าน
      if (password != expectedPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Incorrect password')),
        );
        print('Login failed: Incorrect password for $username');
        return;
      }

      // นำไปยัง RoomListPage เมื่อเข้าสู่ระบบสำเร็จ
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Browse(
                  role: role, // ส่ง role ไปยังหน้า Browse
                )),
      );
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
                      minimumSize: const Size(double.infinity, 50),
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
