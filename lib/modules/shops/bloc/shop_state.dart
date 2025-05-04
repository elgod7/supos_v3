part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final List<dynamic> shops;
  ShopLoaded(this.shops);

  @override
  List<Object> get props => [shops];
}

class ShopError extends ShopState {
  final String message;
  ShopError(this.message);

  @override
  List<Object> get props => [message];
}

class ShopAdded extends ShopState {}
