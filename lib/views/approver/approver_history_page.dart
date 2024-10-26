import 'package:flutter/material.dart';

class ApproverHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Approver History')),
      body: Center(
        child: Text('History of booking approvals will be displayed here.'),
      ),
    );
  }
}
