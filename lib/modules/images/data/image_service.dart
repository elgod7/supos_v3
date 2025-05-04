// image_service.dart
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/supabase/supabase_service.dart';
import 'package:http/http.dart' as http;

class ImageService {
  final SupabaseClient _supabase = SupabaseService().getClient();

  Future<String?> upload(File image, String folder) async {
    try {
      final path = '$folder/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await _supabase.storage.from('product-images').upload(path, image);
      return _supabase.storage.from('product-images').getPublicUrl(path);
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<bool> delete(String imageUrl) async {
    try {
      final path = imageUrl.split('/').last;
      await _supabase.storage.from('product-images').remove([path]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> update(File image, String imageUrl, String folder) async {
    try {
      final path = imageUrl != ''? imageUrl.split('/').last : '$folder/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await _supabase.storage.from('product-images').update(path, image);
      return _supabase.storage.from('product-images').getPublicUrl(path);
    } catch (e) {
      throw Exception('Error updating image: $e');
    }
  }

  Future<bool> isImageValid(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
