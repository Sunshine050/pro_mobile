import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredReservations = [];
  bool _isSearching = false;
  bool _isLoading = true;

  // ฟังก์ชันดึงข้อมูลการจองพร้อมการยืนยันตัวตน
  Future<void> fetchReservations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // ดึง token จาก SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        print('Token not found. Please login again.');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // ส่งคำขอ API พร้อม token ใน headers
      final response = await http.get(
        Uri.parse('http://192.168.206.1:3000/user/history'),
        headers: {
          'Authorization':
              'Bearer $token', 
        },
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        setState(() {
          filteredReservations =
              List<Map<String, dynamic>>.from(data.map((item) => {
                    'room_title': item['room_name'],
                    'time': getSlotTime(item['slot']),
                    'date': item['booking_date'],
                    'formatted_date': getFormattedDate(item['booking_date']),
                    'status': item['status'],
                    'approver': item['approved_by'],
                    'reason': item['reason'],
                  }));

          filteredReservations.sort((a, b) =>
              DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));

          _isLoading = false;
        });
      } else {
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error connecting to server: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  String getSlotTime(String slot) {
    switch (slot) {
      case 'slot_1':
        return '8:00-10:00';
      case 'slot_2':
        return '10:00-12:00';
      case 'slot_3':
        return '13:00-15:00';
      case 'slot_4':
        return '15:00-17:00';
      default:
        return 'Unknown Slot';
    }
  }

  String getFormattedDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(parsedDate);
  }

  @override
  void initState() {
    super.initState();
    fetchReservations();
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
        fetchReservations();
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
          child: Text(
            'Reservation History',
            // ลบ fontWeight ออกเพื่อทำให้เป็นตัวธรรมดา
            style: TextStyle(),
          ),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    filled: true,
                    fillColor: Colors.white70,
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : filteredReservations.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: _searchController.text.isNotEmpty
                          ? Text(
                              'No results found for "${_searchController.text}"',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.calendar_today,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'No reservations found',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                    ),
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
                                vertical: 8.0, horizontal: 16.0),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                maxLines: 1,
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                reservation['time'],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                              Text(
                                                reservation['formatted_date'],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.blueGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  reservation['status']
                                                              .toLowerCase() ==
                                                          'approved'
                                                      ? const Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green)
                                                      : reservation['status']
                                                                  .toLowerCase() ==
                                                              'pending'
                                                          ? const Icon(
                                                              Icons
                                                                  .hourglass_empty,
                                                              color:
                                                                  Colors.orange)
                                                          : const Icon(
                                                              Icons.cancel,
                                                              color:
                                                                  Colors.red),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    reservation['status'],
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: reservation[
                                                                      'status']
                                                                  .toLowerCase() ==
                                                              'approved'
                                                          ? Colors.green
                                                          : reservation['status']
                                                                      .toLowerCase() ==
                                                                  'pending'
                                                              ? Colors.orange
                                                              : Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 2),
                                              if (reservation['status']
                                                          .toLowerCase() !=
                                                      'canceled' &&
                                                  reservation['approver'] !=
                                                      null)
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Icon(
                                                          Icons.person,
                                                          color: Colors.blue,
                                                          size: 16,
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          'By: [${reservation['approver'] ?? 'Not assigned'}]',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color:
                                                                Colors.blueGrey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      height: 1,
                                      color: Colors.grey[300],
                                    ),
                                    const SizedBox(height: 10),
                                    if (reservation['reason'] != null &&
                                        reservation['reason'] != '')
                                      Text(
                                        'Reason: ${reservation['reason']}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blueGrey),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}