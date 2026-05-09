enum VisitorStatus { pending, approved, inside, exited, rejected }
 
class Visitor {
  final String id;
  final String studentId;
  final String studentName;
  final String roomNumber;
  final String visitorName;
  final String visitorPhone;
  final String relationship;
  final String purpose;
  final int numberOfVisitors;
  final VisitorStatus status;
  final String? qrCode;
  final String? otp;
  final DateTime? entryTime;
  final DateTime? exitTime;
  final DateTime createdAt;
 
  Visitor({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.roomNumber,
    required this.visitorName,
    required this.visitorPhone,
    required this.relationship,
    required this.purpose,
    this.numberOfVisitors = 1,
    this.status = VisitorStatus.pending,
    this.qrCode,
    this.otp,
    this.entryTime,
    this.exitTime,
    required this.createdAt,
  });
 
  factory Visitor.fromJson(Map<String, dynamic> json) => Visitor(
    id: json['id'], studentId: json['studentId'], studentName: json['studentName'],
    roomNumber: json['roomNumber'], visitorName: json['visitorName'],
    visitorPhone: json['visitorPhone'], relationship: json['relationship'],
    purpose: json['purpose'], numberOfVisitors: json['numberOfVisitors'] ?? 1,
    status: VisitorStatus.values.firstWhere((e) => e.name == json['status']),
    qrCode: json['qrCode'], otp: json['otp'],
    entryTime: json['entryTime'] != null ? DateTime.parse(json['entryTime']) : null,
    exitTime: json['exitTime'] != null ? DateTime.parse(json['exitTime']) : null,
    createdAt: DateTime.parse(json['createdAt']),
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'studentId': studentId, 'studentName': studentName,
    'roomNumber': roomNumber, 'visitorName': visitorName,
    'visitorPhone': visitorPhone, 'relationship': relationship,
    'purpose': purpose, 'numberOfVisitors': numberOfVisitors,
    'status': status.name, 'qrCode': qrCode, 'otp': otp,
    'entryTime': entryTime?.toIso8601String(),
    'exitTime': exitTime?.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
  };
}
 