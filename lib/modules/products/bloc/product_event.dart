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
  final Product product;

  AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class EditProduct extends ProductEvent {
  final Product product;

  EditProduct(this.product);

  @override
  List<Object> get props => [product];
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

class AddCategory extends ProductEvent {
  final ProductCategory category;

  AddCategory(this.category);

  @override
  List<Object> get props => [category];
}

class EditCategory extends ProductEvent {
  final ProductCategory category;

  EditCategory(this.category);

  @override
  List<Object> get props => [category];
}

class DeleteCategory extends ProductEvent {
  final int categoryId;
  final int shopId;

  DeleteCategory(this.categoryId, this.shopId);

  @override
  List<Object> get props => [categoryId, shopId];
}

class FetchUnits extends ProductEvent {
  final int shopId;

  FetchUnits(this.shopId);

  @override
  List<Object> get props => [shopId];
}

class AddUnit extends ProductEvent {
  final ProductUnit unit;

  AddUnit(this.unit);

  @override
  List<Object> get props => [unit];
}

class EditUnit extends ProductEvent {
  final ProductUnit unit;

  EditUnit(this.unit);

  @override
  List<Object> get props => [unit];
}

class DeleteUnit extends ProductEvent {
  final int unitId;
  final int shopId;

  DeleteUnit(this.unitId, this.shopId);

  @override
  List<Object> get props => [unitId, shopId];
}
