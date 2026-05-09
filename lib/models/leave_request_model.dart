enum LeaveStatus { pending, approved, rejected, cancelled }
enum LeaveType { home, medical, emergency, outstation }
 
class LeaveRequest {
  final String id;
  final String studentId;
  final String studentName;
  final String roomNumber;
  final LeaveType type;
  final String reason;
  final DateTime departureDate;
  final DateTime returnDate;
  final String parentName;
  final String parentContact;
  final LeaveStatus status;
  final String? wardenComment;
  final String? qrCode;
  final DateTime createdAt;
  final DateTime? updatedAt;
 
  LeaveRequest({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.roomNumber,
    required this.type,
    required this.reason,
    required this.departureDate,
    required this.returnDate,
    required this.parentName,
    required this.parentContact,
    this.status = LeaveStatus.pending,
    this.wardenComment,
    this.qrCode,
    required this.createdAt,
    this.updatedAt,
  });
 
  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
    id: json['id'],
    studentId: json['studentId'],
    studentName: json['studentName'],
    roomNumber: json['roomNumber'],
    type: LeaveType.values.firstWhere((e) => e.name == json['type']),
    reason: json['reason'],
    departureDate: DateTime.parse(json['departureDate']),
    returnDate: DateTime.parse(json['returnDate']),
    parentName: json['parentName'],
    parentContact: json['parentContact'],
    status: LeaveStatus.values.firstWhere((e) => e.name == json['status']),
    wardenComment: json['wardenComment'],
    qrCode: json['qrCode'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'studentId': studentId, 'studentName': studentName,
    'roomNumber': roomNumber, 'type': type.name, 'reason': reason,
    'departureDate': departureDate.toIso8601String(),
    'returnDate': returnDate.toIso8601String(),
    'parentName': parentName, 'parentContact': parentContact,
    'status': status.name, 'wardenComment': wardenComment, 'qrCode': qrCode,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
 
  int get duration => returnDate.difference(departureDate).inDays;
  bool get isActive => status == LeaveStatus.approved &&
      DateTime.now().isAfter(departureDate) &&
      DateTime.now().isBefore(returnDate);
}