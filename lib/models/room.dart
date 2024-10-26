// lib/models/room.dart
class Room {
  final String id;
  final String name;

  Room({required this.id, required this.name});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
    );
  }
}
