import 'package:flutter/material.dart';

import '../../data/image_service.dart';

class SafeNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;

  const SafeNetworkImage({
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: ImageService()
          .isImageValid(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildPlaceholder();
        }
        
        if (snapshot.hasData && snapshot.data == true) {
          return Image.network(
            imageUrl,
            height: height,
            width: width,
            fit: fit,
            loadingBuilder: (context, child, progress) {
              return progress == null ? child : _buildPlaceholder();
            },
            errorBuilder: (context, error, stackTrace) {
              return _buildPlaceholder();
            },
          );
        }
        return _buildPlaceholder();
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      height: height,
      width: width,
      child: const Icon(Icons.image_not_supported, color: Colors.grey),
    );
  }
}