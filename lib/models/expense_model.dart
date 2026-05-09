class HostelFee {
  final String id;
  final String studentId;
  final String type; // hostel | mess | laundry | fine
  final double amount;
  final double? paidAmount;
  final String status; // paid | pending | overdue
  final DateTime dueDate;
  final DateTime? paidAt;
  final String description;
 
  HostelFee({
    required this.id, required this.studentId, required this.type,
    required this.amount, this.paidAmount, required this.status,
    required this.dueDate, this.paidAt, required this.description,
  });
 
  factory HostelFee.fromJson(Map<String, dynamic> json) => HostelFee(
    id: json['id'], studentId: json['studentId'], type: json['type'],
    amount: json['amount'].toDouble(), paidAmount: json['paidAmount']?.toDouble(),
    status: json['status'], dueDate: DateTime.parse(json['dueDate']),
    paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
    description: json['description'],
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'studentId': studentId, 'type': type, 'amount': amount,
    'paidAmount': paidAmount, 'status': status,
    'dueDate': dueDate.toIso8601String(), 'paidAt': paidAt?.toIso8601String(),
    'description': description,
  };
 
  double get balance => amount - (paidAmount ?? 0);
}