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
  final double stockQuantity;
  final int unit;

  AddProduct(this.shopId, this.name, this.description, this.categoryId,
      this.price, this.costPrice, this.stockQuantity, this.unit);

  @override
  List<Object> get props => [
        shopId,
        name,
        description,
        categoryId,
        price,
        costPrice,
        stockQuantity,
        unit
      ];
}

class EditProduct extends ProductEvent {
  final int productId;
  final int shopId;
  final int categoryId;
  final String name;
  final String description;
  final double price;
  final double costPrice;
  final double stockQuantity;
  final int unitId;

  EditProduct(
    this.productId,
    this.shopId,
    this.name,
    this.description,
    this.categoryId,
    this.price,
    this.costPrice,
    this.stockQuantity,
    this.unitId,
  );

  @override
  List<Object> get props => [
        productId,
        shopId,
        name,
        description,
        categoryId,
        price,
        costPrice,
        stockQuantity,
        unitId
      ];
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

class EditCategory extends ProductEvent {
  final int categoryId;
  final int shopId;
  final String name;

  EditCategory(this.categoryId, this.name, this.shopId);

  @override
  List<Object> get props => [categoryId, name, shopId];
}

class DeleteCategory extends ProductEvent {
  final int categoryId;
  final int shopId;

  DeleteCategory(this.categoryId, this.shopId);

  @override
  List<Object> get props => [categoryId, shopId];
}

class AddCategory extends ProductEvent {
  final int shopId;
  final String name;

  AddCategory(this.shopId, this.name);

  @override
  List<Object> get props => [shopId, name];
}

class FetchUnits extends ProductEvent {
  final int shopId;

  FetchUnits(this.shopId);

  @override
  List<Object> get props => [shopId];
}

class EditUnit extends ProductEvent {
  final int unitId;
  final String name;
  final int shopId;

  EditUnit(this.unitId, this.name, this.shopId);

  @override
  List<Object> get props => [unitId, name, shopId];
}

class DeleteUnit extends ProductEvent {
  final int unitId;
  final int shopId;

  DeleteUnit(this.unitId, this.shopId);

  @override
  List<Object> get props => [unitId, shopId];
}

class AddUnit extends ProductEvent {
  final int shopId;
  final String name;

  AddUnit(this.shopId, this.name);

  @override
  List<Object> get props => [shopId, name];
}
