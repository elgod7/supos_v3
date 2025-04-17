import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supos_v3/modules/products/model/product_model.dart';
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
    on<AddCategory>(_onAddCategory);
    on<EditCategory>(_onEditCategory);
    on<DeleteCategory>(_onDeleteCategory);
    on<FetchUnits>(_onFetchUnits);
    on<EditUnit>(_onEditUnit);
    on<DeleteUnit>(_onDeleteUnit);
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.fetchProducts(event.shopId);
      final categories = await productRepository.fetchCategories(event.shopId);
      final units = await productRepository.fetchUnits(event.shopId);
      //add(FetchCategories(event.shopId));
      emit(ProductLoaded(products, categories, units));
    } catch (e) {
      emit(ProductError('Failed to load products: ${e.toString()}'));
    }
  }

  Future<void> _onAddProduct(
      AddProduct event, Emitter<ProductState> emit) async {
    try {
      await productRepository.addProduct(event.product);
      add(FetchProducts(event.product.shopId)); // Refresh product list
      emit(ProductAdded());
    } catch (e) {
      emit(ProductError('Failed to add product: ${e.toString()}'));
    }
  }

  Future<void> _onEditProduct(
      EditProduct event, Emitter<ProductState> emit) async {
    try {
      await productRepository.editProduct(event.product);
      add(FetchProducts(event.product.shopId));
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
      emit(ProductLoading());
      final categories = await productRepository.fetchCategories(event.shopId);
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(ProductError('Failed to load categories: ${e.toString()}'));
    }
  }

  Future<void> _onAddCategory(
      AddCategory event, Emitter<ProductState> emit) async {
    try {
      await productRepository.addCategory(event.category);
      add(FetchCategories(event.category.shopId));
      emit(ProductAdded());
    } catch (e) {
      emit(ProductError('Failed to add category: ${e.toString()}'));
    }
  }

  Future<void> _onEditCategory(
      EditCategory event, Emitter<ProductState> emit) async {
    try {
      await productRepository.editCategory(event.category);
      add(FetchCategories(event.category.shopId));
      emit(CategoryEdited());
    } catch (e) {
      emit(ProductError('Failed to edit category: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteCategory(
      DeleteCategory event, Emitter<ProductState> emit) async {
    try {
      await productRepository.deleteCategory(event.categoryId);
      add(FetchCategories(event.shopId));
      emit(CategoryDeleted());
    } catch (e) {
      emit(ProductError('Failed to delete category: ${e.toString()}'));
    }
  }

  // Fetch units

  Future<void> _onFetchUnits(
      FetchUnits event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading());
      final units = await productRepository.fetchUnits(event.shopId);
      emit(UnitLoaded(units));
    } catch (e) {
      emit(ProductError('Failed to load units: ${e.toString()}'));
    }
  }

  Future<void> _onAddUnit(
    AddUnit event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await productRepository.addUnit(event.unit);
      add(FetchUnits(event.unit.shopId));
    } catch (e) {
      emit(ProductError('Failed to add unit: ${e.toString()}'));
    }
  }

  Future<void> _onEditUnit(EditUnit event, Emitter<ProductState> emit) async {
    try {
      await productRepository.editUnit(event.unit);
      add(FetchUnits(event.unit.shopId));
      emit(UnitEdited());
    } catch (e) {
      emit(ProductError('Failed to edit unit: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteUnit(
      DeleteUnit event, Emitter<ProductState> emit) async {
    try {
      await productRepository.deleteUnit(event.unitId);
      add(FetchUnits(event.shopId));
      emit(UnitDeleted());
    } catch (e) {
      emit(ProductError('Failed to delete unit: ${e.toString()}'));
    }
  }
}
