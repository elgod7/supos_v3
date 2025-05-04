class Shop {
  final int id;
  final String name;
  final String description;
  final String location;

  Shop(
      {required this.id,
      required this.name,
      required this.description,
      required this.location});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
    };
  }

  @override
  String toString() {
    return 'Shop{id: $id, name: $name, description: $description, location: $location}';
  }
}

class UserShop {
  final Shop shop;
  final String roleName;
  final String? userName;

  UserShop({
    required this.shop,
    required this.roleName,
    this.userName,
  });

  factory UserShop.fromJson(Map<String, dynamic> json) {
    return UserShop(
      shop: Shop.fromJson(json['shops']),
      roleName: json['roles']['name'],
      userName: json['users']?['full_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shop': shop.toJson(),
      'roleName': roleName,
      'userName': userName,
    };
  }

  @override
  String toString() {
    return 'UserShop{shop: $shop, roleName: $roleName, userName: $userName}';
  }
}
