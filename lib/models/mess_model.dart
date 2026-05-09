class MessMenu {
  final String id;
  final DateTime date;
  final String breakfast;
  final String lunch;
  final String snacks;
  final String dinner;
  final List<String> breakfastItems;
  final List<String> lunchItems;
  final List<String> snacksItems;
  final List<String> dinnerItems;
 
  MessMenu({
    required this.id,
    required this.date,
    required this.breakfast,
    required this.lunch,
    required this.snacks,
    required this.dinner,
    this.breakfastItems = const [],
    this.lunchItems = const [],
    this.snacksItems = const [],
    this.dinnerItems = const [],
  });
 
  factory MessMenu.fromJson(Map<String, dynamic> json) => MessMenu(
    id: json['id'],
    date: DateTime.parse(json['date']),
    breakfast: json['breakfast'],
    lunch: json['lunch'],
    snacks: json['snacks'],
    dinner: json['dinner'],
    breakfastItems: List<String>.from(json['breakfastItems'] ?? []),
    lunchItems: List<String>.from(json['lunchItems'] ?? []),
    snacksItems: List<String>.from(json['snacksItems'] ?? []),
    dinnerItems: List<String>.from(json['dinnerItems'] ?? []),
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'date': date.toIso8601String(),
    'breakfast': breakfast, 'lunch': lunch, 'snacks': snacks, 'dinner': dinner,
    'breakfastItems': breakfastItems, 'lunchItems': lunchItems,
    'snacksItems': snacksItems, 'dinnerItems': dinnerItems,
  };
}
 
class MealAttendance {
  final String id;
  final String studentId;
  final DateTime date;
  final bool breakfast;
  final bool lunch;
  final bool snacks;
  final bool dinner;
 
  MealAttendance({
    required this.id,
    required this.studentId,
    required this.date,
    this.breakfast = true,
    this.lunch = true,
    this.snacks = true,
    this.dinner = true,
  });
 
  factory MealAttendance.fromJson(Map<String, dynamic> json) => MealAttendance(
    id: json['id'], studentId: json['studentId'],
    date: DateTime.parse(json['date']),
    breakfast: json['breakfast'] ?? true, lunch: json['lunch'] ?? true,
    snacks: json['snacks'] ?? true, dinner: json['dinner'] ?? true,
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'studentId': studentId, 'date': date.toIso8601String(),
    'breakfast': breakfast, 'lunch': lunch, 'snacks': snacks, 'dinner': dinner,
  };
}
 
class MessFeedback {
  final String id;
  final String studentId;
  final DateTime date;
  final String meal;
  final double rating;
  final String? comment;
 
  MessFeedback({
    required this.id, required this.studentId, required this.date,
    required this.meal, required this.rating, this.comment,
  });
 
  factory MessFeedback.fromJson(Map<String, dynamic> json) => MessFeedback(
    id: json['id'], studentId: json['studentId'],
    date: DateTime.parse(json['date']), meal: json['meal'],
    rating: json['rating'].toDouble(), comment: json['comment'],
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'studentId': studentId, 'date': date.toIso8601String(),
    'meal': meal, 'rating': rating, 'comment': comment,
  };
}