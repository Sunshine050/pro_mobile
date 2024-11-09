import 'package:flutter/material.dart';

class ApproveRequestPage extends StatefulWidget {
  @override
  _ApproveRequestPageState createState() => _ApproveRequestPageState();
}

class _ApproveRequestPageState extends State<ApproveRequestPage> {
  final List<Map<String, dynamic>> originalReservations = [
    {
      "roomTitle": "Room A",
      "time": "08:00 - 10:00",
      "date": "01/01/2077",
      "userName": "John Doe",
      "reason": "Meeting discussion",
    },
    {
      "roomTitle": "Room B",
      "time": "10:00 - 12:00",
      "date": "01/01/2077",
      "userName": "Jane Smith",
      "reason": "Project planning",
    },
    {
      "roomTitle": "Room C",
      "time": "12:00 - 14:00",
      "date": "01/01/2077",
      "userName": "Michael Brown",
      "reason": "Training session",
    },
  ];

  List<Map<String, dynamic>> reservations = [];

  get actioned => null;

  @override
  void initState() {
    super.initState();
    // Initialize reservations with original data
    reservations = List.from(originalReservations);
  }

  void _showConfirmationDialog(BuildContext context, String action, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm $action'),
          content: Text('Are you sure you want to $action this request?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  reservations.removeAt(index); // Remove the reservation
                });
                // Close the dialog
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text('Request $actioned successfully!'),
                //   ),
                // );
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _refreshReservations() {
    setState(() {
      reservations = List.from(originalReservations); // Reset to original data
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Reservation Status'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _refreshReservations, // Refresh button
            ),
          ],
        ),
        body: reservations.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Icon(
                    Icons.edit_note,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No reservations awaiting approval.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer()
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: reservations.length,
                      itemBuilder: (context, index) {
                        final reservation = reservations[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reservation['roomTitle'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(reservation['time']),
                                Text(reservation['date']),
                                SizedBox(height: 8),
                                Text("Req by: ${reservation['userName']}"),
                                SizedBox(height: 8),
                                TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: 'Reason',
                                    hintText: reservation['reason'],
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        _showConfirmationDialog(
                                            context, 'approve', index);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.check),
                                          SizedBox(width: 4),
                                          Text('Approve'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showConfirmationDialog(
                                            context, 'reject', index);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.close),
                                          SizedBox(width: 4),
                                          Text('Reject'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
