// Data Models
class Product {
  final int id;
  final int shopId;
  final String name;
  final String description;
  final int categoryId;
  final String categoryName;
  final double price;
  final double costPrice;
  final double stockQuantity;
  final int unitId;
  final String unitName;
  final String imageUrl;

  Product({
    required this.id,
    required this.shopId,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.categoryName,
    required this.price,
    required this.costPrice,
    required this.stockQuantity,
    required this.unitId,
    required this.unitName,
    required this.imageUrl,
    // this.imageUrls = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      shopId: json['shop_id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      categoryId: json['category_id'] as int,
      categoryName: (json['product_categories'] as Map<String, dynamic>)['name']
          as String,
      price: (json['price'] as num).toDouble(),
      costPrice: (json['cost_price'] as num).toDouble(),
      stockQuantity: (json['stock_quantity'] as num).toDouble(),
      unitId: json['unit_id'] as int,
      unitName:
          (json['product_units'] as Map<String, dynamic>)['name'] as String,
      imageUrl: json['image_url'] as String,
      //imageUrls: (json['image_urls'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'id': id,
      'shop_id': shopId,
      'name': name,
      'description': description,
      'category_id': categoryId,
      'price': price,
      'cost_price': costPrice,
      'stock_quantity': stockQuantity,
      'unit_id': unitId,
      'image_url': imageUrl,
      //'image_urls': imageUrls, // Include image URLs in JSON
    };
  }
}

class ProductCategory {
  final int id;
  final int shopId;
  final String name;

  ProductCategory({
    required this.id,
    required this.shopId,
    required this.name,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as int,
      shopId: json['shop_id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_id': shopId,
      'name': name,
    };
  }
}

class ProductUnit {
  final int id;
  final int shopId;
  final String name;

  ProductUnit({
    required this.id,
    required this.shopId,
    required this.name,
  });

  factory ProductUnit.fromJson(Map<String, dynamic> json) {
    return ProductUnit(
      id: json['id'] as int,
      shopId: json['shop_id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_id': shopId,
      'name': name,
    };
  }
}
