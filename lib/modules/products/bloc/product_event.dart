part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {
  final int shopId;

  FetchProducts(this.shopId);

  @override
  List<Object> get props => [shopId];
}

class AddProduct extends ProductEvent {
  final int shopId;
  final String name;
  final String description;
  final int categoryId;
  final double price;
  final double costPrice;
  final int stockQuantity;
  final String unit;

  AddProduct(this.shopId, this.name, this.description, this.categoryId,
      this.price, this.costPrice, this.stockQuantity, this.unit);

  @override
  List<Object> get props =>
      [shopId, name,description, categoryId, price, costPrice, stockQuantity, unit];
}

class EditProduct extends ProductEvent {
  final int productId;
  final int shopId;
  final String name;
  final String description;
  final double price;
  final double costPrice;
  final int stockQuantity;
  final String unit;

  EditProduct(this.productId, this.shopId, this.name, this.description,this.price,
      this.costPrice, this.stockQuantity, this.unit);

  @override
  List<Object> get props =>
      [productId, shopId, name,description, price, costPrice, stockQuantity, unit];
}

class DeleteProduct extends ProductEvent {
  final int productId;
  final int shopId;

  DeleteProduct(this.productId, this.shopId);

  @override
  List<Object> get props => [productId, shopId];
}

class FetchCategories extends ProductEvent {
  final int shopId;

  FetchCategories(this.shopId);

  @override
  List<Object> get props => [shopId];
}
