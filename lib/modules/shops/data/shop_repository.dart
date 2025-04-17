import 'package:supabase_flutter/supabase_flutter.dart';

import '../view/model/shop_model.dart';

class ShopRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Fetch shops linked to the logged-in user
  Future<List<dynamic>> fetchUserShops() async {
    try {
      final response = await _supabase
          .from('user_shops')
          .select('shops(*), roles(name), users(full_name)')
          .eq('user_id', await _getUserId());

      // Handle empty data
      if (response.isEmpty) {
        return [];
      }
      return (response as List<dynamic>).map((json) => UserShop.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('An error occurred while fetching shops: $e');
    }
  }

  /// Add a shop and link it to the logged-in user with the 'owner' role
  Future<void> addShop(Shop shop) async {
    try {
      final userId = await _getUserId(); // Fetch user ID from public.users

      // Insert the new shop and get its ID
      final shopResponse = await _supabase
          .from('shops')
          .insert(shop.toJson())
          .select('id')
          .single();

      final shopId = shopResponse['id']; // Get the shop ID

      // Fetch the 'owner' role_id
      final roleResponse = await _supabase
          .from('roles')
          .select('id')
          .eq('name', 'owner')
          .single();

      final ownerRoleId = roleResponse['id']; // Get the owner role ID

      // Link the shop to the user with the 'owner' role
      await _supabase.from('user_shops').insert({
        'user_id': userId,
        'shop_id': shopId,
        'role_id': ownerRoleId,
      });
    } catch (e) {
      throw Exception('An error occurred while adding the shop: $e');
    }
  }

  /// Listen for real-time updates in the shops table
  Stream<List<dynamic>> listenToShops() {
    return _supabase
        .from('shops')
        .stream(primaryKey: ['id']).map((event) => event);
  }

  /// Edit a shop’s details
  Future<void> editShop(Shop shop) async {
    try {
      await _supabase.from('shops').update({
        'name': shop.name,
        'description': shop.description,
        'location': shop.location,
      }).eq('id', shop.id);
    } catch (e) {
      throw Exception('Error editing shop: $e');
    }
  }

  /// Delete a shop
  Future<void> deleteShop(int shopId) async {
    try {
      await _supabase.from('shops').delete().eq('id', shopId);
    } catch (e) {
      throw Exception('Error deleting shop: $e');
    }
  }

  /// Get the user ID from the public.users table using auth_user_id
  Future<int> _getUserId() async {
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
}
