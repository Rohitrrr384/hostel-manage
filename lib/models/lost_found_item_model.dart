class LostFoundItem {
  final String id;
  final String reportedBy;
  final String reporterName;
  final String type; // lost | found
  final String title;
  final String description;
  final String location;
  final List<String> images;
  final bool isResolved;
  final DateTime createdAt;
 
  LostFoundItem({
    required this.id, required this.reportedBy, required this.reporterName,
    required this.type, required this.title, required this.description,
    required this.location, this.images = const [], this.isResolved = false,
    required this.createdAt,
  });
 
  factory LostFoundItem.fromJson(Map<String, dynamic> json) => LostFoundItem(
    id: json['id'], reportedBy: json['reportedBy'], reporterName: json['reporterName'],
    type: json['type'], title: json['title'], description: json['description'],
    location: json['location'], images: List<String>.from(json['images'] ?? []),
    isResolved: json['isResolved'] ?? false,
    createdAt: DateTime.parse(json['createdAt']),
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'reportedBy': reportedBy, 'reporterName': reporterName,
    'type': type, 'title': title, 'description': description,
    'location': location, 'images': images, 'isResolved': isResolved,
    'createdAt': createdAt.toIso8601String(),
  };
}