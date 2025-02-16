part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchShops extends ShopEvent {}

class AddShop extends ShopEvent {
  final String name;
  final String description;
  final String location;

  AddShop(this.name, this.description, this.location);

  @override
  List<Object> get props => [name, description, location];
}

class EditShop extends ShopEvent {
  final int shopId;
  final String name;
  final String description;
  final String location;

  EditShop(this.shopId, this.name, this.description, this.location);

  @override
  List<Object> get props => [shopId, name, description, location];
}

class DeleteShop extends ShopEvent {
  final int shopId;

  DeleteShop(this.shopId);

  @override
  List<Object> get props => [shopId];
}

class ShopsUpdated extends ShopEvent {}
