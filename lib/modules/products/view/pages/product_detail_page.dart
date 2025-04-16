import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/product_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;
  final Map<String, dynamic> productInitial;
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> units;
  final String shopName;

  const ProductDetailPage(
      {super.key,
      required this.productId,
      required this.productInitial,
      required this.categories,
      required this.units,
      required this.shopName});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> product = productInitial;

    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoading) {
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (state is ProductError) {
        return Center(child: Text(state.message));
      } else if (state is ProductLoaded) {
        // Display product details
        product = state.products.firstWhere((p) => p['id'] == productId,
            orElse: () => productInitial); // Find the product by ID
      } else {
        product = productInitial; // Use the initial product data
      }
      return Scaffold(
          appBar: AppBar(
            title: Text(product['name']),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop(true); // Navigate back to the previous page
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  context
                      .push('/products/detail/${product['id']}/edit', extra: {
                    'product': product,
                    'categories': categories,
                    'units': units,
                  }); // Navigate to product detail page

                  // Navigate to edit product page
                  // Navigator.pushNamed(context, '/edit_product', arguments: productId);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Show confirmation dialog before deleting
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Product'),
                      content: const Text(
                          'Are you sure you want to delete this product?'),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: const Text('Delete'),
                          onPressed: () {
                            // Call delete product function
                            context.read<ProductBloc>().add(DeleteProduct(
                                product['id'], product['shop_id']));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Product deleted successfully!'),
                              ),
                            );
                            // Optionally, navigate back or pop the dialog
                            context.push(
                                '/products/${productInitial['shop_id']}?shopName= $shopName');
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          body: Builder(builder: (context) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 220,
                      color: Colors.grey[200],
                      child:
                          const Center(child: Icon(Icons.image_not_supported)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Product Name
                  Text(
                    product['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Price
                  Text(
                    '\$${product['price'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }));
    });
  }
}
