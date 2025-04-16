import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/product_bloc.dart';

class ProductEditPage extends StatefulWidget {
  final Map<String, dynamic> product;
  final List<Map<String, dynamic>> categoryOptions;
  final List<Map<String, dynamic>> unitOptions;

  const ProductEditPage({
    required this.product,
    required this.categoryOptions,
    super.key,
    required this.unitOptions,
  });

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController costPriceController;
  late TextEditingController stockController;
  //late TextEditingController unitController;

  int? selectedCategoryId;
  int? selectedUnitId;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product['name']);
    descriptionController =
        TextEditingController(text: widget.product['description']);
    priceController =
        TextEditingController(text: widget.product['price'].toString());
    costPriceController =
        TextEditingController(text: widget.product['cost_price'].toString());
    stockController = TextEditingController(
        text: widget.product['stock_quantity'].toString());
    selectedUnitId = widget.product['unit_id'];
    selectedCategoryId = widget.product['category_id'];
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final shopId = widget.product['shop_id'];
    final productId = widget.product['id'];

    final updated = EditProduct(
      productId,
      shopId,
      nameController.text.trim(),
      descriptionController.text.trim(),
      selectedCategoryId!,
      double.parse(priceController.text),
      double.parse(costPriceController.text),
      double.parse(stockController.text),
      selectedUnitId!,
    );

    context.read<ProductBloc>().add(updated);
    context.read<ProductBloc>().add(FetchProducts(shopId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('✅ Product updated')),
            );
            Navigator.pop(context, true);
          } else if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Product Name'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                DropdownButtonFormField<int>(
                  value: selectedCategoryId,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: widget.categoryOptions.map((category) {
                    final int id = category['id'];
                    final String name = category['name'];
                    return DropdownMenuItem<int>(
                      value: id,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => selectedCategoryId = val),
                  validator: (val) => val == null ? 'Select category' : null,
                ),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Selling Price'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: costPriceController,
                  decoration: InputDecoration(labelText: 'Cost Price'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: stockController,
                  decoration: InputDecoration(labelText: 'Stock Quantity'),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<int>(
                  value: selectedUnitId,
                  decoration: const InputDecoration(labelText: 'Unit'),
                  items: widget.unitOptions.map((unit) {
                    final int id = unit['id'];
                    final String name = unit['name'];
                    return DropdownMenuItem<int>(
                      value: id,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => selectedUnitId = val),
                  validator: (val) => val == null ? 'Select Unit' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _submit,
                  icon: Icon(Icons.save),
                  label: Text('Save'),
                ),
                Text('${widget.unitOptions}')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
