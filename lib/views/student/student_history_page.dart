import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // int _currentIndex = 2; // Default to History tab
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredReservations = [];
  bool _isSearching = false;

  // Sample reservations
  final List<Map<String, dynamic>> reservations = [
    {
      'room_title': 'Room 1',
      'time': '08:00 - 10:00',
      'date': '01/01/2077',
      'status': 'Approved',
      'approver': 'John Doe',
      'reason': 'Project discussion meeting',
    },
    {
      'room_title': 'Room 2',
      'time': '08:00 - 10:00',
      'date': '01/01/2077',
      'status': 'Rejected',
      'approver': 'Jane Doe',
      'reason': 'Team building session',
    },
    {
      'room_title': 'Room 3',
      'time': '08:00 - 10:00',
      'date': '01/01/2077',
      'status': 'Canceled',
      'approver': null,
      'reason': 'Personal reasons',
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredReservations = reservations; // Initialize filtered list with reservations
  }

  void _filterReservations(String query) {
    setState(() {
      filteredReservations = reservations.where((reservation) {
        return reservation['room_title'].toLowerCase().contains(query.toLowerCase()) ||
               reservation['status'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _toggleSearchBar() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        filteredReservations = reservations; // Reset the list
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text('Reservation History'),
        ),
        actions: [
          if (_isSearching)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 150,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                  onChanged: _filterReservations,
                ),
              ),
            )
          else
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _toggleSearchBar,
            ),
        ],
      ),
      body: filteredReservations.isEmpty
          ? Center(
              child: _searchController.text.isNotEmpty
                  ? Text('No results found for "${_searchController.text}"')
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 100,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'No reservations found',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
            )
          : ListView.builder(
              itemCount: filteredReservations.length,
              itemBuilder: (context, index) {
                final reservation = filteredReservations[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left Side
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reservation['room_title'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '${reservation['time']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '${reservation['date']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Right Side
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      reservation['status'] == 'Approved'
                                          ? Icon(Icons.check_circle,
                                              color: Colors.green)
                                          : reservation['status'] == 'Rejected'
                                              ? Icon(Icons.cancel,
                                                  color: Colors.red)
                                              : Icon(Icons.cancel,
                                                  color: Colors.grey),
                                      SizedBox(width: 4),
                                      Text(
                                        reservation['status'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: reservation['status'] ==
                                                  'Approved'
                                              ? Colors.green
                                              : reservation['status'] ==
                                                      'Rejected'
                                                  ? Colors.red
                                                  : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  // Show the approver only if the status is not 'Canceled'
                                  if (reservation['status'] != 'Canceled')
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'By: [${reservation['approver'] ?? 'Not assigned'}]',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        // Add Reason section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reason',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                '${reservation['reason'] ?? 'No reason provided'}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
