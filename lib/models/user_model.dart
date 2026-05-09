class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role; // student | warden | security | mess | admin
  final String? studentId;
  final String? roomNumber;
  final String? block;
  final String? hostelName;
  final String? profileImage;
  final bool isActive;
  final DateTime createdAt;
 
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.studentId,
    this.roomNumber,
    this.block,
    this.hostelName,
    this.profileImage,
    this.isActive = true,
    required this.createdAt,
  });
 
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    role: json['role'],
    studentId: json['studentId'],
    roomNumber: json['roomNumber'],
    block: json['block'],
    hostelName: json['hostelName'],
    profileImage: json['profileImage'],
    isActive: json['isActive'] ?? true,
    createdAt: DateTime.parse(json['createdAt']),
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'email': email, 'phone': phone, 'role': role,
    'studentId': studentId, 'roomNumber': roomNumber, 'block': block,
    'hostelName': hostelName, 'profileImage': profileImage,
    'isActive': isActive, 'createdAt': createdAt.toIso8601String(),
  };
 
  UserModel copyWith({
    String? name, String? phone, String? roomNumber, String? profileImage,
  }) => UserModel(
    id: id, email: email, role: role, createdAt: createdAt,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    studentId: studentId, block: block, hostelName: hostelName,
    roomNumber: roomNumber ?? this.roomNumber,
    profileImage: profileImage ?? this.profileImage,
  );
}