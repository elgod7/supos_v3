import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supos_v3/utils/shared_components/alert_dialog/show_dialog.dart';

import '../../bloc/shop_bloc.dart';

class ShowEditShopDialog {
  ShowEditShopDialog({required this.shopId, required this.shop}) {
    nameController = TextEditingController(text: shop['name'] ?? '');
    descriptionController =
        TextEditingController(text: shop['description'] ?? '');
    locationController = TextEditingController(text: shop['location'] ?? '');
  }

  final int shopId;
  final Map<String, dynamic> shop;

  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController locationController;

  void show(BuildContext context) {
    ShowFormDialog(
      isEdit: true,
      title: 'Add Shop',
      controllers: [nameController, descriptionController, locationController],
      labels: ['Shop Name', 'Description', 'Location'],
      onEvent: (pageContext) {
        final name = nameController.text;
        final description = descriptionController.text;
        final location = locationController.text;
        final id = shopId;

        pageContext
            .read<ShopBloc>()
            .add(EditShop(id, name, description, location));
      },
    ).show(context);
  }

  void showErrorDialog(BuildContext context, String message) {
    ShowFormDialog.showErrorDialog(context, message);
  }
}
