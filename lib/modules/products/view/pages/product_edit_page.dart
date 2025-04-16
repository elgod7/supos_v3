import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/product_bloc.dart';
import '../../model/product_model.dart';

class ProductEditPage extends StatefulWidget {
  final Product product;
  final List<ProductCategory> categories;
  final List<ProductUnit> units;

  const ProductEditPage({
    required this.product,
    required this.categories,
    required this.units,
    super.key,
  });

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _costPriceController;
  late TextEditingController _stockController;

  late int _selectedCategoryId;
  late int _selectedUnitId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _costPriceController =
        TextEditingController(text: widget.product.costPrice.toString());
    _stockController =
        TextEditingController(text: widget.product.stockQuantity.toString());

    _selectedCategoryId = widget.product.categoryId;
    _selectedUnitId = widget.product.unitId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _costPriceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final updatedProduct = Product(
      id: widget.product.id,
      shopId: widget.product.shopId,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      categoryId: _selectedCategoryId,
      categoryName:
          widget.categories.firstWhere((c) => c.id == _selectedCategoryId).name,
      price: double.parse(_priceController.text),
      costPrice: double.parse(_costPriceController.text),
      stockQuantity: double.parse(_stockController.text),
      unitId: _selectedUnitId,
      unitName: widget.units.firstWhere((u) => u.id == _selectedUnitId).name,
    );

    context.read<ProductBloc>().add(EditProduct(updatedProduct));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ Product updated successfully')),
            );
            Navigator.pop(context, true);
          } else if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    value: _selectedCategoryId,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: widget.categories.map((category) {
                      return DropdownMenuItem<int>(
                        value: category.id,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _selectedCategoryId = val!),
                    validator: (val) => val == null ? 'Select category' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Selling Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Required';
                      if (double.tryParse(value!) == null) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _costPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Cost Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Required';
                      if (double.tryParse(value!) == null) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _stockController,
                    decoration: const InputDecoration(
                      labelText: 'Stock Quantity',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Required';
                      if (double.tryParse(value!) == null) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    value: _selectedUnitId,
                    decoration: const InputDecoration(
                      labelText: 'Unit',
                      border: OutlineInputBorder(),
                    ),
                    items: widget.units.map((unit) {
                      return DropdownMenuItem<int>(
                        value: unit.id,
                        child: Text(unit.name),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedUnitId = val!),
                    validator: (val) => val == null ? 'Select unit' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: state is ProductLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: state is ProductLoading
                        ? const CircularProgressIndicator()
                        : const Text('Update Product'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
