enum MarketplaceCategory { books, electronics, clothes, furniture, food, other }
 
class MarketplaceItem {
  final String id;
  final String sellerId;
  final String sellerName;
  final String roomNumber;
  final String title;
  final String description;
  final double price;
  final MarketplaceCategory category;
  final List<String> images;
  final bool isAvailable;
  final DateTime createdAt;
 
  MarketplaceItem({
    required this.id, required this.sellerId, required this.sellerName,
    required this.roomNumber, required this.title, required this.description,
    required this.price, required this.category, this.images = const [],
    this.isAvailable = true, required this.createdAt,
  });
 
  factory MarketplaceItem.fromJson(Map<String, dynamic> json) => MarketplaceItem(
    id: json['id'], sellerId: json['sellerId'], sellerName: json['sellerName'],
    roomNumber: json['roomNumber'], title: json['title'],
    description: json['description'], price: json['price'].toDouble(),
    category: MarketplaceCategory.values.firstWhere((e) => e.name == json['category']),
    images: List<String>.from(json['images'] ?? []),
    isAvailable: json['isAvailable'] ?? true,
    createdAt: DateTime.parse(json['createdAt']),
  );
 
  Map<String, dynamic> toJson() => {
    'id': id, 'sellerId': sellerId, 'sellerName': sellerName,
    'roomNumber': roomNumber, 'title': title, 'description': description,
    'price': price, 'category': category.name, 'images': images,
    'isAvailable': isAvailable, 'createdAt': createdAt.toIso8601String(),
  };
}
 