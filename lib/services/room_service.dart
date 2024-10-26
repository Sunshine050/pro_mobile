class Room {
  final String id;
  final String name;
  final String status;

  Room({required this.id, required this.name, required this.status});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
    );
  }
}
