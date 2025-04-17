import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/shop_repository.dart';
import '../view/model/shop_model.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository shopRepository;

  ShopBloc(this.shopRepository) : super(ShopInitial()) {
    on<FetchShops>(_onFetchShops);
    on<AddShop>(_onAddShop);
    on<EditShop>(_onEditShop);
    on<DeleteShop>(_onDeleteShop);

    // Start listening for real-time shop updates
    shopRepository.listenToShops().listen((updatedShops) {
      add(ShopsUpdated());
    });

    on<ShopsUpdated>(_onShopsUpdated);
  }

  Future<void> _onFetchShops(FetchShops event, Emitter<ShopState> emit) async {
    emit(ShopLoading());
    try {
      final shops = await shopRepository.fetchUserShops();
      emit(ShopLoaded(shops));
    } catch (e) {
      emit(ShopError('Failed to load shops: $e'));
    }
  }

  Future<void> _onAddShop(AddShop event, Emitter<ShopState> emit) async {
    emit(ShopLoading()); // Show loading state while adding the shop
    try {
      await shopRepository.addShop(
          event.shop);
      // final updatedShops =
      //     await shopRepository.fetchUserShops(); // Fetch updated shop list
      add(FetchShops()); // Refresh shop list
      emit(ShopAdded());
    } catch (e) {
      emit(ShopError('Failed to add shop: $e'));
    }
  }

  Future<void> _onEditShop(EditShop event, Emitter<ShopState> emit) async {
    try {
      await shopRepository.editShop(
          event.shop);
      add(FetchShops());
    } catch (e) {
      emit(ShopError('Failed to edit shop: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteShop(DeleteShop event, Emitter<ShopState> emit) async {
    try {
      await shopRepository.deleteShop(event.shopId);
      add(FetchShops());
    } catch (e) {
      emit(ShopError('Failed to delete shop: ${e.toString()}'));
    }
  }

  Future<void> _onShopsUpdated(
      ShopsUpdated event, Emitter<ShopState> emit) async {
    try {
      final updatedShops = await shopRepository.fetchUserShops();
      emit(ShopLoaded(updatedShops));
    } catch (e) {
      emit(ShopError('Failed to update shops: $e'));
    }
  }
}
