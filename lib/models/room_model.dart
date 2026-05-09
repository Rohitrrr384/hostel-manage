class Room {
  final String id;
  final String number;
  final String block;
  final String hostel;
  final int capacity;
  final int currentOccupancy;
  final String type; // single | double | triple
  final List<String> occupants;
  final bool isAvailable;
 
  Room({
    required this.id, required this.number, required this.block,
    required this.hostel, required this.capacity, required this.currentOccupancy,
    required this.type, this.occupants = const [], required this.isAvailable,
  });
 
  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json['id'], number: json['number'], block: json['block'],
    hostel: json['hostel'], capacity: json['capacity'],
    currentOccupancy: json['currentOccupancy'], type: json['type'],
    occupants: List<String>.from(json['occupants'] ?? []),
    isAvailable: json['isAvailable'],
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'number': number, 'block': block, 'hostel': hostel,
    'capacity': capacity, 'currentOccupancy': currentOccupancy, 'type': type,
    'occupants': occupants, 'isAvailable': isAvailable,
  };
}
 