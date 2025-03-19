import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/product_bloc.dart';
import '../data/product_repository.dart';
import 'pages/add_product_page.dart';
import 'product_widgets/show_add_product_dialog.dart';
import 'product_widgets/show_edit_product_dialog.dart';

class ProductPage extends StatelessWidget {
  final int shopId;
  final String? shopName;

  const ProductPage({required this.shopId, super.key, required this.shopName});

  @override
  Widget build(BuildContext context) {
    // Fetch categories
    List<dynamic> categories = [];

    return BlocProvider(
      create: (context) {
        return ProductBloc(ProductRepository())..add(FetchProducts(shopId));
        // ..add(FetchCategories(shopId));
      },
      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is CategoryLoaded) {
            categories = state.categories;
          }

          if (state is ProductError) {
            ShowAddProductDialog(shopId: shopId, categoryOptions: categories)
                .showErrorDialog(context, state.message);
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
                            onPressed: () =>
                                ShowEditProductDialog(shopId, product)
                                    .show(context),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => context
                                .read<ProductBloc>()
                                .add(DeleteProduct(product['id'], shopId)),
                          ),
                        ],
                      ),
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
            return FloatingActionButton(
              onPressed: () => 
               context.push('/products/$shopId/add'), // Navigate to add product page
              // AddProductPage(
              //         categoryOptions: categories, shopId: shopId)
              //     .show(context),
              child: Icon(Icons.add),
            );
          }),
        ),
      ),
    );
  }
}
