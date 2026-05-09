enum NoticeCategory { important, urgent, events, exams, maintenance, general }
 
class Notice {
  final String id;
  final String title;
  final String content;
  final NoticeCategory category;
  final String postedBy;
  final List<String> attachments;
  final bool isPinned;
  final DateTime? expiresAt;
  final DateTime createdAt;
 
  Notice({
    required this.id, required this.title, required this.content,
    this.category = NoticeCategory.general, required this.postedBy,
    this.attachments = const [], this.isPinned = false,
    this.expiresAt, required this.createdAt,
  });
 
  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
    id: json['id'], title: json['title'], content: json['content'],
    category: NoticeCategory.values.firstWhere((e) => e.name == json['category']),
    postedBy: json['postedBy'],
    attachments: List<String>.from(json['attachments'] ?? []),
    isPinned: json['isPinned'] ?? false,
    expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
    createdAt: DateTime.parse(json['createdAt']),
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'title': title, 'content': content, 'category': category.name,
    'postedBy': postedBy, 'attachments': attachments, 'isPinned': isPinned,
    'expiresAt': expiresAt?.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
  };
}