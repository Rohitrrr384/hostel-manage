enum ComplaintStatus { pending, assigned, inProgress, resolved, closed }
enum ComplaintPriority { low, medium, high, urgent }
enum ComplaintCategory {
  water, electricity, wifi, cleanliness, fan, furniture, harassment, other
}
 
class Complaint {
  final String id;
  final String studentId;
  final String studentName;
  final String roomNumber;
  final ComplaintCategory category;
  final String title;
  final String description;
  final ComplaintPriority priority;
  final ComplaintStatus status;
  final List<String> images;
  final String? assignedTo;
  final String? resolution;
  final double? rating;
  final String? ratingComment;
  final DateTime createdAt;
  final DateTime? resolvedAt;
 
  Complaint({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.roomNumber,
    required this.category,
    required this.title,
    required this.description,
    this.priority = ComplaintPriority.medium,
    this.status = ComplaintStatus.pending,
    this.images = const [],
    this.assignedTo,
    this.resolution,
    this.rating,
    this.ratingComment,
    required this.createdAt,
    this.resolvedAt,
  });
 
  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
    id: json['id'],
    studentId: json['studentId'],
    studentName: json['studentName'],
    roomNumber: json['roomNumber'],
    category: ComplaintCategory.values.firstWhere((e) => e.name == json['category']),
    title: json['title'],
    description: json['description'],
    priority: ComplaintPriority.values.firstWhere((e) => e.name == json['priority']),
    status: ComplaintStatus.values.firstWhere((e) => e.name == json['status']),
    images: List<String>.from(json['images'] ?? []),
    assignedTo: json['assignedTo'],
    resolution: json['resolution'],
    rating: json['rating']?.toDouble(),
    ratingComment: json['ratingComment'],
    createdAt: DateTime.parse(json['createdAt']),
    resolvedAt: json['resolvedAt'] != null ? DateTime.parse(json['resolvedAt']) : null,
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'studentId': studentId, 'studentName': studentName,
    'roomNumber': roomNumber, 'category': category.name, 'title': title,
    'description': description, 'priority': priority.name, 'status': status.name,
    'images': images, 'assignedTo': assignedTo, 'resolution': resolution,
    'rating': rating, 'ratingComment': ratingComment,
    'createdAt': createdAt.toIso8601String(),
    'resolvedAt': resolvedAt?.toIso8601String(),
  };
}