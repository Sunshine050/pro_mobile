import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredReservations = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }

  Future<void> fetchReservations() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.206.1/student/history'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          filteredReservations = data.map((item) {
            return {
              'room_title': item['room_name'],
              'time': item['time'],
              'date': item['booking_date'],
              'status': item['status'],
              'approver': item['approved_by'] != null ? item['approved_by'] : 'Not assigned',
              'reason': item['reason'] ?? 'No reason provided',
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load reservations');
      }
    } catch (e) {
      print('Error fetching reservations: $e');
    }
  }

  void _filterReservations(String query) {
    setState(() {
      filteredReservations = filteredReservations.where((reservation) {
        return reservation['room_title']
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            reservation['status'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _toggleSearchBar() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        fetchReservations(); // Reset the list when search is closed
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
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Reservation History'),
        ),
        actions: [
          if (_isSearching)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: 150,
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                  onChanged: _filterReservations,
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _toggleSearchBar,
            ),
        ],
      ),
      body: filteredReservations.isEmpty
          ? Column(
              children: [
                Center(
                  child: _searchController.text.isNotEmpty
                      ? Text('No results found for "${_searchController.text}"')
                      : const Column(
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                )
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Left Side
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          reservation['room_title'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${reservation['time']}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '${reservation['date']}',
                                          style: const TextStyle(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            reservation['status'] == 'Approved'
                                                ? const Icon(Icons.check_circle,
                                                    color: Colors.green)
                                                : reservation['status'] == 
                                                        'Rejected'
                                                    ? const Icon(Icons.cancel,
                                                        color: Colors.red)
                                                    : const Icon(Icons.cancel,
                                                        color: Colors.grey),
                                            const SizedBox(width: 4),
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
                                        const SizedBox(height: 2),
                                        if (reservation['status'] != 'Canceled')
                                          Text(
                                            'By: ${reservation['approver']}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Reason',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      reservation['reason'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
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
                )
              ],
            ),
    );
  }
}
