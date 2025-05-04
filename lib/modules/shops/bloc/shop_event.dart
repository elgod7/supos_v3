part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchShops extends ShopEvent {}

class AddShop extends ShopEvent {
  final Shop shop;

  AddShop(this.shop);

  @override
  List<Object> get props => [shop];
}

class EditShop extends ShopEvent {
  final Shop shop;

  EditShop(this.shop);

  @override
  List<Object> get props => [shop];
}

class DeleteShop extends ShopEvent {
  final int shopId;

  DeleteShop(this.shopId);

  @override
  List<Object> get props => [shopId];
}

class ShopsUpdated extends ShopEvent {}
