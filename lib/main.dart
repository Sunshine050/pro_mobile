import 'package:flutter/material.dart';
import 'package:mobile_project/services/database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Counter',
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    int? count = await _dbHelper.getCounter();
    setState(() {
      _counter = count ?? 0;
    });
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await _dbHelper.saveCounter(_counter); // บันทึกค่าตัวนับในฐานข้อมูลหลังเพิ่ม
  }

  Future<void> _saveCounter() async {
    print("Saving counter value: $_counter");
    await _dbHelper.saveCounter(_counter); // บันทึกค่าตัวนับในฐานข้อมูล
    _loadCounter(); // โหลดค่าตัวนับใหม่เพื่ออัปเดต UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(width: 16), // เพิ่มช่องว่างระหว่างปุ่ม
          FloatingActionButton(
            onPressed: _saveCounter,
            tooltip: 'Save',
            child: Icon(Icons.save), // ใช้ไอคอนสำหรับปุ่ม Save
          ),
        ],
      ),
    );
  }
}
