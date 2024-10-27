import 'package:flutter/material.dart';
import 'package:pro_mobile/views/staff/manage_rooms_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ManageRoomsPage(),
      debugShowCheckedModeBanner: false, 
    );
  }
}
