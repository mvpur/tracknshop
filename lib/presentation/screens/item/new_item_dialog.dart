import 'package:flutter/material.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/type_amount.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';
import 'package:track_shop_app/presentation/widgets/utils/snackbar.dart';

class NewItemDialog extends ConsumerWidget {
  const NewItemDialog(this.warehouseId, this.catalogueId, this.category,
      {super.key});
  final String? warehouseId;
  final String? catalogueId;
  final String? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    final categories = ref.watch(categoryProvider);

    final filteredCategories = categories.where((category) {
      final isLinkedToCurrent =
          (warehouseId != null && category.warehouseId == warehouseId) ||
              (catalogueId != null && category.catalogueId == catalogueId);
      final isUnlinked =
          category.warehouseId == null && category.catalogueId == null;

      return isLinkedToCurrent || isUnlinked;
    }).toList();

    String? selectedCategoryId;
    TypeAmount? selectedTypeAmount;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'New Item',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name of new item',
                  hintText: 'Milk',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.interests_outlined),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: 'e.g., 2.5',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<TypeAmount>(
                value: selectedTypeAmount,
                decoration: const InputDecoration(
                  labelText: 'Select Unit',
                  border: OutlineInputBorder(),
                ),
                items: TypeAmount.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedTypeAmount = value;
                },
              ),
              const SizedBox(height: 20.0),
              filteredCategories.isNotEmpty
                  ? DropdownButtonFormField<String>(
                      value: selectedCategoryId,
                      decoration: const InputDecoration(
                        labelText: 'Select Category',
                        border: OutlineInputBorder(),
                      ),
                      items: filteredCategories.map((category) {
                        return DropdownMenuItem(
                          value: category.id,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedCategoryId = value;
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'No categories available to select.',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                        ),
                      ),
                    ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final String itemName = nameController.text.trim();
                      final double? amount =
                          double.tryParse(amountController.text.trim());
                      if (itemName.isNotEmpty &&
                          selectedCategoryId != null &&
                          selectedTypeAmount != null &&
                          amount != null) {
                        final newItem = Item(
                          id: '',
                          name: itemName,
                          catalogueId: catalogueId,
                          warehouseId: warehouseId,
                          categoryId: selectedCategoryId,
                          amount: amount,
                          typeAmount: selectedTypeAmount!.name,
                        );
                        ref.read(itemProvider.notifier).addItem(newItem);
                        Navigator.of(context).pop();
                      } else {
                        SnackbarUtil.showSnackbar(
                          context,
                          'Please complete all fields.',
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
