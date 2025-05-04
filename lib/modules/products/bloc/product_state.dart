part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<dynamic> products;
  final List<dynamic> categories;
  final List<dynamic> units;

  ProductLoaded(this.products, this.categories, this.units);

  @override
  List<Object> get props => [products, categories, units];
}

class ProductAdded extends ProductState {}

class ProductUpdated extends ProductState {}

class ProductDeleted extends ProductState {}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryLoading extends ProductState {}

class CategoryLoaded extends ProductState {
  final List<dynamic> categories;

  CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryEdited extends ProductState {}

class CategoryDeleted extends ProductState {}

class UnitLoaded extends ProductState {
  final List<dynamic> units;

  UnitLoaded(this.units);

  @override
  List<Object> get props => [units];
}

class UnitEdited extends ProductState {}

class UnitDeleted extends ProductState {}
