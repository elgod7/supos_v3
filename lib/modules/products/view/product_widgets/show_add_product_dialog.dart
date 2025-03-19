import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supos_v3/utils/helpers/form_validators.dart.dart';

import '../../../../utils/shared_components/alert_dialog/show_dialog.dart';
import '../../bloc/product_bloc.dart';

class ShowAddProductDialog {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final costPriceController = TextEditingController();
  final stockController = TextEditingController();
  final unitController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final int shopId;

  List<dynamic> categoryOptions; // Store categories

  ShowAddProductDialog({required this.shopId, required this.categoryOptions});

  List<String? Function(String?)>? validators = [
    FormValidators.validateField, // Custom validator for required field
    FormValidators.noValidation, // No validation for description
    FormValidators.validateField,
    FormValidators.noValidation,
    FormValidators.noValidation,
    FormValidators.validateField, // Unit
    FormValidators.validateField, // Category (Dropdown)
  ];

  void show(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    productBloc.add(FetchCategories(shopId)); // Fetch categories

    ShowFormDialog(
      isEdit: false,
      validators: validators,
      title: 'Add Product',
      controllers: [
        nameController,
        descriptionController,
        priceController,
        costPriceController,
        stockController,
        unitController,
        categoryController,
      ],
      labels: [
        'Product Name',
        'Description',
        'Selling Price',
        'Cost Price',
        'Stock Quantity',
        'Unit',
        'Category',
      ],
      dropdownLabels: ['Category'], // Dropdown field label
      dropdownItems: [categoryOptions], // Dropdown items
      onEvent: (pageContext) {
        final name = nameController.text;
        final description = descriptionController.text;
        final price = double.tryParse(priceController.text) ?? 0.0;
        final costPrice = double.tryParse(costPriceController.text) ?? 0.0;
        final stock = int.tryParse(stockController.text) ?? 0;
        final unit = unitController.text;
        final categoryId = int.tryParse(categoryController.text) ?? -1;

        if (categoryId == -1) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please select a category')),
          );
          return;
        }

        pageContext.read<ProductBloc>().add(AddProduct(shopId, name,
            description, categoryId, price, costPrice, stock, unit));
      },
    ).show(context);
  }

  void showErrorDialog(BuildContext context, String message) {
    ShowFormDialog.showErrorDialog(context, message);
  }
}
