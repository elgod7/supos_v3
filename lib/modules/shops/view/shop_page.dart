import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supos_v3/modules/shops/view/shop_widgets/show_add_shop_dialog.dart';
import 'package:supos_v3/utils/helpers/access_helper.dart';
import '../bloc/shop_bloc.dart';
import '../data/shop_repository.dart';
import 'shop_widgets/show_edit_shop_dialog.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopBloc(ShopRepository())
        ..add(FetchShops()), // Provide ShopBloc locally
      child: BlocListener<ShopBloc, ShopState>(
        listener: (context, state) {
          if (state is ShopError) {
            ShowAddShopDialog().showErrorDialog(context, state.message);
          } else if (state is ShopAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Shop added successfully!')),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text('Shops')),
          body: BlocBuilder<ShopBloc, ShopState>(
            builder: (context, state) {
              if (state is ShopLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ShopLoaded) {
                return ListView.builder(
                  itemCount: state.shops.length,
                  itemBuilder: (context, index) {
                    final userShop = state.shops[index];
                    return ListTile(
                      title:
                          Text('${userShop.shop.name} (${userShop.roleName})'),
                      subtitle: Text(userShop.shop.location ?? 'No location'),
                      trailing: isOwner(userShop.roleName)
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => ShowEditShopDialog(
                                          shopId: userShop.shop.id,
                                          shop: userShop.shop)
                                      .show(context),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    context
                                        .read<ShopBloc>()
                                        .add(DeleteShop(userShop.shop.id));
                                  },
                                ),
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.grey),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.grey),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                      onTap: () {
                        context.push(
                          '/products/${userShop.shop.id}?shopName=${userShop.shop.name}',
                        );
                      },
                    );
                  },
                );
              } else if (state is ShopError) {
                return Center(child: Text(state.message));
              }
              return Center(child: Text('No shops found.'));
            },
          ),
          floatingActionButton:
              BlocBuilder<ShopBloc, ShopState>(builder: (context, state) {
            return FloatingActionButton(
              onPressed: () => ShowAddShopDialog().show(context),
              child: Icon(Icons.add),
            );
          }),
        ),
      ),
    );
  }
}
