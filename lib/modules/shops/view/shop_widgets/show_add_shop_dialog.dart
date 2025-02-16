import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supos_v3/utils/helpers/form_validators.dart.dart';
import 'package:supos_v3/utils/shared_components/alert_dialog/show_dialog.dart';

import '../../bloc/shop_bloc.dart';

class ShowAddShopDialog {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  List<String? Function(String?)>? validators = [
    FormValidators.validateField, // Custom validator for required field
    FormValidators.noValidation, // No validation for description
    FormValidators.validateField,
  ];

  void show(BuildContext context) {
    ShowFormDialog(
      isEdit: false,
      title: 'Add Shop',
      controllers: [nameController, descriptionController, locationController],
      labels: ['Shop Name', 'Description', 'Location'],
      validators: validators,
      onEvent: (pageContext) {
        final name = nameController.text;
        final description = descriptionController.text;
        final location = locationController.text;

        pageContext.read<ShopBloc>().add(AddShop(name, description, location));
      },
    ).show(context);
  }

  void showErrorDialog(BuildContext context, String message) {
    ShowFormDialog.showErrorDialog(context, message);
  }
}
