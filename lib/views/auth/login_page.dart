import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Log In",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  signIn(context, usernameController.text, passwordController.text);
                },
                child: Text('SIGN IN'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New Member?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register'); // Navigate to register
                    },
                    child: Text("Register now"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn(BuildContext context, String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill in all fields"),
      ));
      return;
    }

    if (username == 'student' && password == '1234') {
      Navigator.pushReplacementNamed(context, '/student_dashboard');
    } else if (username == 'staff' && password == '1234') {
      Navigator.pushReplacementNamed(context, '/staff_dashboard');
    } else if (username == 'approver' && password == '1234') {
      Navigator.pushReplacementNamed(context, '/approver_dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid username or password"),
      ));
    }
  }
}
