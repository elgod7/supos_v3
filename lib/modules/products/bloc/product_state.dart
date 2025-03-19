part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<dynamic> products;

  ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
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

class CategoryLoaded extends ProductState {
  final List<dynamic> categories;

  CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}
