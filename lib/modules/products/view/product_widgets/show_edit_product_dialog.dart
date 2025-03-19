import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supos_v3/utils/helpers/form_validators.dart.dart';

import '../../../../utils/shared_components/alert_dialog/show_dialog.dart';
import '../../bloc/product_bloc.dart';

class ShowEditProductDialog {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final costPriceController = TextEditingController();
  final stockController = TextEditingController();
  final unitController = TextEditingController();
  final int shopId;
  final Map<String, dynamic> product;

  ShowEditProductDialog(this.shopId, this.product);

  List<String? Function(String?)>? validators = [
    FormValidators.validateField, // Custom validator for required field
    FormValidators.noValidation, // No validation for description
    FormValidators.validateField,
  ];

  void show(BuildContext context) {
    nameController.text = product['name'];
    descriptionController.text = product['description'];
    priceController.text = product['price'].toString();
    costPriceController.text = product['cost_price'].toString();
    stockController.text = product['stock_quantity'].toString();
    unitController.text = product['unit'];

    ShowFormDialog(
      isEdit: true,
      title: 'Edit Product',
      controllers: [
        nameController,
        descriptionController,
        priceController,
        costPriceController,
        stockController,
        unitController
      ],
      labels: [
        'Product Name',
        'Description',
        'Selling Price',
        'Cost Price',
        'Stock Quantity',
        'Unit'
      ],
      onEvent: (pageContext) {
        final name = nameController.text;
        final description = descriptionController.text;
        final price = double.tryParse(priceController.text) ?? 0.0;
        final costPrice = double.tryParse(costPriceController.text) ?? 0.0;
        final stock = int.tryParse(stockController.text) ?? 0;
        final unit = unitController.text;

        pageContext.read<ProductBloc>().add(EditProduct(product['id'], shopId,
            name, description, price, costPrice, stock, unit));
      },
    ).show(context);
  }

  void showErrorDialog(BuildContext context, String message) {
    ShowFormDialog.showErrorDialog(context, message);
  }
}
