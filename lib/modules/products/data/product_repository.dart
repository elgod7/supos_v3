import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Fetch all products for a specific shop
  Future<List<dynamic>> fetchProducts(int shopId) async {
    try {
      final response = await _supabase
          .from('products')
          .select('*, product_categories(name), product_units(name)')
          .eq('shop_id', shopId);
      return response;
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  /// Add a new product
  Future<void> addProduct(
      int shopId,
      String name,
      String description,
      int categoryId,
      double price,
      double costPrice,
      double stockQuantity,
      int unit) async {
    try {
      await _supabase.from('products').insert({
        'shop_id': shopId,
        'name': name,
        'description': description,
        'category_id': categoryId,
        'price': price,
        'cost_price': costPrice,
        'stock_quantity': stockQuantity,
        'unit_id': unit,
      });
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  /// Edit an existing product
  Future<void> editProduct(
      int productId,
      String name,
      String description,
      int categoryId,
      double price,
      double costPrice,
      double stockQuantity,
      int unitId) async {
    try {
      await _supabase.from('products').update({
        'name': name,
        'description': description,
        'category_id': categoryId,
        'price': price,
        'cost_price': costPrice,
        'stock_quantity': stockQuantity,
        'unit_id': unitId,
      }).eq('id', productId);
    } catch (e) {
      throw Exception('Error editing product: $e');
    }
  }

  /// Delete a product
  Future<void> deleteProduct(int productId) async {
    try {
      await _supabase.from('products').delete().eq('id', productId);
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

  // Future<int> _getShopId() async {
  //   try {
  //     final response = await _supabase
  //         .from('users')
  //         .select('id')
  //         .eq('auth_user_id', _supabase.auth.currentUser!.id)
  //         .single();

  //     return response['id'];
  //   } catch (e) {
  //     throw Exception('An error occurred while fetching the user ID: $e');
  //   }
  // }

  Future<List<dynamic>> fetchCategories(int shopId) async {
    try {
      final response = await _supabase
          .from('product_categories')
          .select('*')
          .eq('shop_id', shopId);
      return response;
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<void> addCategory(int shopId, String name) async {
    try {
      await _supabase.from('product_categories').insert({
        'shop_id': shopId,
        'name': name,
      });
    } catch (e) {
      throw Exception('Error adding category: $e');
    }
  }

  Future<List<dynamic>> fetchUnits(int shopId) async {
    try {
      final response = await _supabase
          .from('product_units')
          .select('*')
          .eq('shop_id', shopId);
      return response;
    } catch (e) {
      throw Exception('Error fetching units: $e');
    }
  }

  Future<void> addUnit(int shopId, String name) async {
    try {
      await _supabase.from('product_units').insert({
        'shop_id': shopId,
        'name': name,
      });
    } catch (e) {
      throw Exception('Error adding unit: $e');
    }
  }

  Future<void> deleteUnit(int unitId) async {
    try {
      await _supabase.from('product_units').delete().eq('id', unitId);
    } catch (e) {
      throw Exception('Error deleting unit: $e');
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    try {
      await _supabase.from('product_categories').delete().eq('id', categoryId);
    } catch (e) {
      throw Exception('Error deleting category: $e');
    }
  }

  Future<void> editCategory(int categoryId, String name) async {
    try {
      await _supabase.from('product_categories').update({
        'name': name,
      }).eq('id', categoryId);
    } catch (e) {
      throw Exception('Error editing category: $e');
    }
  }

  Future<void> editUnit(int unitId, String name) async {
    try {
      await _supabase.from('product_units').update({
        'name': name,
      }).eq('id', unitId);
    } catch (e) {
      throw Exception('Error editing unit: $e');
    }
  }
}
