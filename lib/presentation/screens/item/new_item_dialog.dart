import 'package:flutter/material.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';
import 'package:track_shop_app/presentation/widgets/snackbar.dart';

class NewItemDialog extends ConsumerWidget {
  const NewItemDialog(this.warehouseId, this.catalogueId, this.categoryId,
      {super.key});
  final String? warehouseId;
  final String? catalogueId;
  final String? categoryId;

  static const String name = 'new_item';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    final categories = ref.watch(categoryProvider);

    // Filtrar categorías según el origen (warehouse o catalogue)
    final filteredCategories = categories.where((category) {
      if (warehouseId != null) {
        return category.warehouseId == warehouseId;
      } else if (catalogueId != null) {
        return category.catalogueId == catalogueId;
      }
      return false;
    }).toList();

    String? selectedCategoryId;

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
                  : const Center(
                      child: Text('No categories available for selection'),
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
                      if (itemName.isNotEmpty && selectedCategoryId != null) {
                        final newItem = Item(
                          id: '',
                          name: itemName,
                          catalogueId: catalogueId,
                          warehouseId: warehouseId,
                          categoryId: selectedCategoryId,
                        );
                        ref.read(itemProvider.notifier).addItem(newItem);
                        Navigator.of(context).pop();
                      } else {
                        SnackbarUtil.showSnackbar(
                          context,
                          'Please fill all fields!',
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
