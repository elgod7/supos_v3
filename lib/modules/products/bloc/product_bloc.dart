import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<AddProduct>(_onAddProduct);
    on<EditProduct>(_onEditProduct);
    on<DeleteProduct>(_onDeleteProduct);
    on<FetchCategories>(_onFetchCategories);
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.fetchProducts(event.shopId);
      //add(FetchCategories(event.shopId));
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Failed to load products: ${e.toString()}'));
    }
  }

  Future<void> _onAddProduct(
      AddProduct event, Emitter<ProductState> emit) async {
    try {
      await productRepository.addProduct(
          event.shopId,
          event.name,
          event.description,
          event.categoryId,
          event.price,
          event.costPrice,
          event.stockQuantity,
          event.unit);
      add(FetchProducts(event.shopId)); // Refresh product list
      emit(ProductAdded());
    } catch (e) {
      emit(ProductError('Failed to add product: ${e.toString()}'));
    }
  }

  Future<void> _onEditProduct(
      EditProduct event, Emitter<ProductState> emit) async {
    try {
      await productRepository.editProduct(
          event.productId,
          event.name,
          event.description,
          event.price,
          event.costPrice,
          event.stockQuantity,
          event.unit);
      add(FetchProducts(event.shopId));
      emit(ProductUpdated());
    } catch (e) {
      emit(ProductError('Failed to edit product: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProduct event, Emitter<ProductState> emit) async {
    try {
      await productRepository.deleteProduct(event.productId);
      add(FetchProducts(event.shopId));
      emit(ProductDeleted());
    } catch (e) {
      emit(ProductError('Failed to delete product: ${e.toString()}'));
    }
  }

  Future<void> _onFetchCategories(
      FetchCategories event, Emitter<ProductState> emit) async {
    try {
      final categories = await productRepository.fetchCategories(event.shopId);
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(ProductError('Failed to load categories: ${e.toString()}'));
    }
  }
}
