import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/product_bloc.dart';
import '../data/product_repository.dart';

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
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ProductLoading) {
            // Show loading indicator
          } else if (state is ProductLoaded) {
            // Handle product loaded state
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Products loaded successfully!')),
            );
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
        child: Scaffold(
          appBar: AppBar(title: Text('Products for $shopName shop')),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProductLoaded) {
                return ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ListTile(
                      title: Text(product['name']),
                      subtitle: Text('Stock: ${product['stock_quantity']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => {},
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => {},
                          ),
                        ],
                      ),
                      onTap: () async {
                        final result = await context
                            .push('/products/detail/${product['id']}', extra: {
                          'product': product,
                          'categories': state.categories,
                          'units': state.units,
                        });

                        if (result == true) {
                          context
                              .read<ProductBloc>()
                              .add(FetchProducts(shopId));
                        }
                        // Navigate to product detail page
                      },
                    );
                  },
                );
              } else if (state is ProductError) {
                return Center(child: Text(state.message));
              }
              return Center(child: Text('No products found.'));
            },
          ),
          floatingActionButton:
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ProductLoaded) {
              return FloatingActionButton(
                onPressed: () async {
                  final result =
                      await context.push('/products/$shopId/add', extra: {
                    //'shopId': shopId,
                    'categories': state.categories,
                    'units': state.units,
                  });

                  if (result == true) {
                    context.read<ProductBloc>().add(FetchProducts(shopId));
                  }
                }, // Navigate to product detail page
                child: Icon(Icons.add),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ),
      ),
    );
  }
}
