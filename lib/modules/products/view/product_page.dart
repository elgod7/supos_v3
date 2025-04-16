import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/product_bloc.dart';
import '../data/product_repository.dart';
import '../model/product_model.dart';

class ProductPage extends StatelessWidget {
  final int shopId;
  final String? shopName;

  const ProductPage({required this.shopId, super.key, required this.shopName});

  @override
  Widget build(BuildContext context) {
    // Fetch categories

    return BlocProvider(
        create: (context) {
          return ProductBloc(ProductRepository())..add(FetchProducts(shopId));
          // ..add(FetchCategories(shopId));
        },
        child: Scaffold(
          appBar: AppBar(title: Text('Products for $shopName shop')),
          body: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is ProductLoading) {
                // Show loading indicator
              } else if (state is ProductLoaded) {
              } else if (state is ProductAdded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Product added successfully!')),
                );
              } else if (state is ProductUpdated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Product updated successfully!')),
                );
              } else if (state is ProductDeleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Product deleted successfully!')),
                );
              }
            },
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProductLoaded) {
                return _buildProductList(context, state, shopName);
              } else if (state is ProductError) {
                return Center(child: Text(state.message));
              }
              return Center(
                  child:
                      Text('No products found. $shopId ${state.toString()}'));
            },
          ),
          floatingActionButton: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const SizedBox.shrink(); // Hide FAB while loading
              } else if (state is ProductLoaded) {
                return _buildFloatingActionButton(context, shopId, state);
              }
              return const SizedBox.shrink(); // Hide FAB for other states
            },
          ),
        ));
  }
}

Widget _buildProductList(BuildContext context, ProductLoaded state, shopName) {
  return ListView.builder(
    itemCount: state.products.length,
    itemBuilder: (context, index) {
      final Product product = state.products[index];
      return ListTile(
        title: Text(product.name),
        subtitle: Text('Stock: ${product.stockQuantity}'),
        // trailing: IconButton(
        //   icon: Icon(Icons.delete),
        //   onPressed: () {
        //     context.read<ProductBloc>().add(DeleteProduct(product['id'], product['shop_id']));
        //   },
        // ),
        onTap: () => _navigateToProductDetail(
            context, product, state, product.shopId, shopName),
      );
    },
  );
}

Widget _buildFloatingActionButton(BuildContext context, int shopId, state) {
  return FloatingActionButton(
    onPressed: () => _navigateToAddProduct(context, shopId, state),
    child: const Icon(Icons.add),
  );
}

// void _navigateToEditProduct(
//     BuildContext context, Map<String, dynamic> product, ProductLoaded state) async {
//   final result = await context.push('/products/${product['id']}/edit', extra: {
//     'product': product,
//     'categories': state.categories,
//     'units': state.units,
//   });

//   if (result == true) {
//     // Product was updated, refresh the list
//     context.read<ProductBloc>().add(FetchProducts(shopId));
//   }
// }

void _navigateToProductDetail(BuildContext context, Product product,
    ProductLoaded state, int shopId, String shopName) async {
  final result = await context.push('/products/detail/${product.id}', extra: {
    'product': product,
    'categories': state.categories,
    'units': state.units,
    'shopName': shopName,
  });

  if (result == true) {
    // Product was updated or deleted, refresh the list
    context.read<ProductBloc>().add(FetchProducts(shopId));
  }
}

void _navigateToAddProduct(
    BuildContext context, int shopId, ProductLoaded state) async {
  final result = await context.push('/products/$shopId/add', extra: {
    'categories': state.categories,
    'units': state.units,
  });

  if (result == true) {
    // New product was added, refresh the list
    context.read<ProductBloc>().add(FetchProducts(shopId));
  }
}

  // void _deleteProduct(BuildContext context, int productId) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Delete Product'),
  //       content: const Text('Are you sure you want to delete this product?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //             context.read<ProductBloc>().add(DeleteProduct(productId));
  //           },
  //           child: const Text('Delete', style: TextStyle(color: Colors.red)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

