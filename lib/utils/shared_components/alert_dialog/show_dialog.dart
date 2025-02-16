import 'package:flutter/material.dart';
import 'package:supos_v3/utils/constants/type.dart';

import '../../constants/app_sizes.dart';
import '../component_styles.dart';

class ShowFormDialog {
  final _formKey = GlobalKey<FormState>();
  final String title;
  final List<TextEditingController> controllers;
  final List<String> labels;
  final Function(BuildContext) onEvent;
  final List<FormFieldValidator<String>>? validators;
  final bool isEdit;

  ShowFormDialog({
    required this.title,
    required this.controllers,
    required this.labels,
    required this.onEvent,
    this.validators,
    required this.isEdit,
  }) {
    // Ensure validators list is not null and has the same length as controllers
    if (!isEdit) {
      if (validators == null || validators!.length != controllers.length) {
        throw ArgumentError(
            "Validators list must have the same number of elements as controllers.");
      }
    }
  }

  void show(BuildContext context) {
    _showAddDialog(context);
  }

  void _showAddDialog(BuildContext pageContext) {
    showDialog(
      context: pageContext,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(controllers.length, (index) {
              return Column(
                children: [
                  AppSizes.defaultVerticalSpace,
                  TextFormField(
                    controller: controllers[index],
                    decoration: textFieldDecoration(label: labels[index]),
                    validator:
                        isEdit ? null : (value) => validators?[index](value),
                  ),
                ],
              );
            }),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: secondaryButtonStyle(
                    context: context, size: SizeOption.small),
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                style: primaryButtonStyle(
                    context: context, size: SizeOption.small),
                onPressed: () {
                  if (isEdit) {
                    onEvent(pageContext);
                    Navigator.pop(context);
                  } else if (_formKey.currentState?.validate() ?? false) {
                    onEvent(pageContext);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
