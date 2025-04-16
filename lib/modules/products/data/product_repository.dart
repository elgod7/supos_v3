import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/product_model.dart';
import 'package:image_picker/image_picker.dart';

class ProductRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Add this constant for your bucket name
  static const String productImagesBucket = 'product_images';

  /// Fetch all products for a specific shop
  Future<List<dynamic>> fetchProducts(int shopId) async {
    try {
      final response = await _supabase
          .from('products')
          .select('*, product_categories(name), product_units(name)')
          .eq('shop_id', shopId);
      return (response as List<dynamic>)
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  /// Add a new product
  Future<void> addProduct(Product product) async {
    try {
      await _supabase.from('products').insert(product.toJson());
    } catch (e) {
      throw Exception('Error adding product: $e');
    }
  }

  /// Edit an existing product
  Future<void> editProduct(Product product) async {
    try {
      await _supabase
          .from('products')
          .update(product.toJson())
          .eq('id', product.id);
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

  Future<List<String>> uploadProductImages(
      int productId, List<XFile> imageFiles) async {
    final List<String> imageUrls = [];

    for (final file in imageFiles) {
      final fileExtension = file.name.split('.').last;
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
      final filePath = '$productId/$fileName';

      final fileBytes = await file.readAsBytes();

      await _supabase.storage
          .from(productImagesBucket)
          .upload(filePath, fileBytes as File);

      final imageUrl =
          _supabase.storage.from(productImagesBucket).getPublicUrl(filePath);

      imageUrls.add(imageUrl);
    }

    return imageUrls;
  }

  Future<void> deleteProductImage(String imageUrl) async {
    try {
      final path = imageUrl.split('/').last;
      await _supabase.storage.from(productImagesBucket).remove([path]);
    } catch (e) {
      throw Exception('Error deleting image: $e');
    }
  }

  // Update these methods to handle images

  Future<List<dynamic>> fetchCategories(int shopId) async {
    try {
      final response = await _supabase
          .from('product_categories')
          .select('*')
          .eq('shop_id', shopId);
      return (response as List<dynamic>)
          .map((json) => ProductCategory.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<void> addCategory(ProductCategory category) async {
    try {
      await _supabase.from('product_categories').insert({
        'shop_id': category.shopId,
        'name': category.name,
      });
    } catch (e) {
      throw Exception('Error adding category: $e');
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    try {
      await _supabase.from('product_categories').delete().eq('id', categoryId);
    } catch (e) {
      throw Exception('Error deleting category: $e');
    }
  }

  Future<void> editCategory(ProductCategory category) async {
    try {
      await _supabase.from('product_categories').update({
        'name': category.name,
      }).eq('id', category.id);
    } catch (e) {
      throw Exception('Error editing category: $e');
    }
  }

  Future<List<dynamic>> fetchUnits(int shopId) async {
    try {
      final response = await _supabase
          .from('product_units')
          .select('*')
          .eq('shop_id', shopId);
      return (response as List<dynamic>)
          .map((json) => ProductUnit.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching units: $e');
    }
  }

  Future<void> addUnit(ProductUnit unit) async {
    try {
      await _supabase.from('product_units').insert({
        'shop_id': unit.shopId,
        'name': unit.name,
      });
    } catch (e) {
      throw Exception('Error adding unit: $e');
    }
  }

  Future<void> editUnit(ProductUnit unit) async {
    try {
      await _supabase.from('product_units').update({
        'name': unit.name,
      }).eq('id', unit.id);
    } catch (e) {
      throw Exception('Error editing unit: $e');
    }
  }

  Future<void> deleteUnit(int unitId) async {
    try {
      await _supabase.from('product_units').delete().eq('id', unitId);
    } catch (e) {
      throw Exception('Error deleting unit: $e');
    }
  }
}
