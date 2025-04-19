import 'package:flutter/material.dart';
import 'package:supos_v3/utils/constants/type.dart';

import '../../constants/app_sizes.dart';
import '../component_styles.dart';

class AddEditPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String title;
  final List<TextEditingController> controllers;
  final List<String> labels;
  final List<String>? dropdownLabels; // Dropdown-specific labels
  final List<List<dynamic>>? dropdownItems; // Dropdown options
  final Function(BuildContext) onEvent;
  final List<FormFieldValidator<String>>? validators;
  final bool isEdit;

  AddEditPage({super.key, 
    required this.title,
    required this.controllers,
    required this.labels,
    this.dropdownLabels,
    this.dropdownItems,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [actions(context)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(controllers.length, (index) {
                if (dropdownItems != null &&
                    dropdownItems!.length > index &&
                    dropdownItems![index].isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSizes.defaultVerticalSpace,
                      Text(
                        dropdownLabels![index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButtonFormField<int>(
                        value: int.tryParse(controllers[index].text),
                        items: dropdownItems![index].map((item) {
                          return DropdownMenuItem<int>(
                            value: item['id'],
                            child: Text(item['name']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controllers[index].text = value.toString();
                        },
                        decoration: InputDecoration(
                            label: Text(dropdownLabels![index])),
                        validator: isEdit
                            ? null
                            : (value) => value == null
                                ? "Please select ${dropdownLabels![index]}"
                                : null,
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      AppSizes.defaultVerticalSpace,
                      TextFormField(
                        controller: controllers[index],
                        decoration: InputDecoration(label: Text(labels[index])),
                        // decoration: textFieldDecoration(label: labels[index]),
                        validator: isEdit
                            ? null
                            : (value) => validators?[index](value),
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
        ),
      ),
    );
  }

  // void show(BuildContext context) {
  //   _showAddDialog(context);
  // }

  void _showAddDialog(BuildContext pageContext) {
    showDialog(
      context: pageContext,
      builder: (context) => SingleChildScrollView(
        child: AlertDialog(
          title: Text(title),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(controllers.length, (index) {
                if (dropdownItems != null &&
                    dropdownItems!.length > index &&
                    dropdownItems![index].isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSizes.defaultVerticalSpace,
                      Text(
                        dropdownLabels![index],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButtonFormField<int>(
                        value: int.tryParse(controllers[index].text),
                        items: dropdownItems![index].map((item) {
                          return DropdownMenuItem<int>(
                            value: item['id'],
                            child: Text(item['name']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controllers[index].text = value.toString();
                        },
                        decoration:
                            textFieldDecoration(label: dropdownLabels![index]),
                        validator: isEdit
                            ? null
                            : (value) => value == null
                                ? "Please select ${dropdownLabels![index]}"
                                : null,
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      AppSizes.defaultVerticalSpace,
                      TextFormField(
                        controller: controllers[index],
                        decoration: textFieldDecoration(label: labels[index]),
                        validator: isEdit
                            ? null
                            : (value) => validators?[index](value),
                      ),
                    ],
                  );
                }
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
                  child: Text(!isEdit ? 'Add' : 'Save'),
                ),
              ],
            ),
          ],
        ),
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

  Widget actions(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (isEdit) {
          onEvent(context);
          Navigator.pop(context);
        } else if (_formKey.currentState?.validate() ?? false) {
          onEvent(context);
          Navigator.pop(context);
        }
      },
      icon: Icon(Icons.save),
    );
  }
}
