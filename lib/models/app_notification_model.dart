class AppNotification {
  final String id;
  final String userId;
  final String title;
  final String body;
  final String type;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime createdAt;
 
  AppNotification({
    required this.id, required this.userId, required this.title,
    required this.body, required this.type, this.data,
    this.isRead = false, required this.createdAt,
  });
 
  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
    id: json['id'], userId: json['userId'], title: json['title'],
    body: json['body'], type: json['type'], data: json['data'],
    isRead: json['isRead'] ?? false, createdAt: DateTime.parse(json['createdAt']),
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'userId': userId, 'title': title, 'body': body, 'type': type,
    'data': data, 'isRead': isRead, 'createdAt': createdAt.toIso8601String(),
  };
}