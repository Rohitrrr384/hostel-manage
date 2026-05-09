enum LaundryStatus { booked, collected, washing, drying, ready, delivered }
 
class LaundrySlot {
  final String id;
  final String studentId;
  final String studentName;
  final String roomNumber;
  final DateTime date;
  final String timeSlot;
  final int itemCount;
  final LaundryStatus status;
  final DateTime createdAt;
 
  LaundrySlot({
    required this.id, required this.studentId, required this.studentName,
    required this.roomNumber, required this.date, required this.timeSlot,
    required this.itemCount, this.status = LaundryStatus.booked,
    required this.createdAt,
  });
 
  factory LaundrySlot.fromJson(Map<String, dynamic> json) => LaundrySlot(
    id: json['id'], studentId: json['studentId'], studentName: json['studentName'],
    roomNumber: json['roomNumber'], date: DateTime.parse(json['date']),
    timeSlot: json['timeSlot'], itemCount: json['itemCount'],
    status: LaundryStatus.values.firstWhere((e) => e.name == json['status']),
    createdAt: DateTime.parse(json['createdAt']),
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'studentId': studentId, 'studentName': studentName,
    'roomNumber': roomNumber, 'date': date.toIso8601String(),
    'timeSlot': timeSlot, 'itemCount': itemCount, 'status': status.name,
    'createdAt': createdAt.toIso8601String(),
  };
}