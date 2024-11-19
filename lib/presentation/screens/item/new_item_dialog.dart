import 'package:flutter/material.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';
import 'package:track_shop_app/presentation/widgets/snackbar.dart';

class NewItemDialog extends ConsumerWidget {
  const NewItemDialog(this.warehouseId, this.catalogueId, this.category,
      {super.key});
  final String? warehouseId;
  final String? catalogueId;
  final String? category;
  static const String name = 'new_item';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    final categories = ref.watch(categoryProvider);

    // Filtrar las categorías asociadas o sin vinculación.
    final filteredCategories = categories.where((category) {
      final isLinkedToCurrent =
          (warehouseId != null && category.warehouseId == warehouseId) ||
              (catalogueId != null && category.catalogueId == catalogueId);
      final isUnlinked =
          category.warehouseId == null && category.catalogueId == null;

      return isLinkedToCurrent || isUnlinked;
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

              // Mostrar Dropdown o mensaje según las categorías disponibles.
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

              // Botones de acción.
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
                            categoryId: selectedCategoryId);
                        ref.read(itemProvider.notifier).addItem(newItem);
                        Navigator.of(context).pop();
                      } else {
                        SnackbarUtil.showSnackbar(
                          context,
                          'Please enter a name and select a category.',
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
