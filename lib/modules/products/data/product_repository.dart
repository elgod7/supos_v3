import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Fetch all products for a specific shop
  Future<List<dynamic>> fetchProducts(int shopId) async {
    try {
      final response = await _supabase
          .from('products')
          .select('*,product_categories(name)')
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
      int stockQuantity,
      String unit) async {
    try {
      await _supabase.from('products').insert({
        'shop_id': shopId,
        'name': name,
        'description': description,
        'category_id': categoryId,
        'price': price,
        'cost_price': costPrice,
        'stock_quantity': stockQuantity,
        'unit': unit,
      });
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  /// Edit an existing product
  Future<void> editProduct(int productId, String name, String description,
      double price, double costPrice, int stockQuantity, String unit) async {
    try {
      await _supabase.from('products').update({
        'name': name,
        'description': description,
        'price': price,
        'cost_price': costPrice,
        'stock_quantity': stockQuantity,
        'unit': unit,
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

  Future<int> _getShopId() async {
    try {
      final response = await _supabase
          .from('users')
          .select('id')
          .eq('auth_user_id', _supabase.auth.currentUser!.id)
          .single();

      return response['id'];
    } catch (e) {
      throw Exception('An error occurred while fetching the user ID: $e');
    }
  }

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
}
