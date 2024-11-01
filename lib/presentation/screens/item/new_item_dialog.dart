import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_screen.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';

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
    final categories = ref.watch(categoryProvider); // Obtén las categorías
    String?
        selectedCategoryId; // Variable para almacenar la categoría seleccionada
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: 600), // Ajusta el ancho máximo aquí
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
              categories.isNotEmpty
                  ? DropdownButtonFormField<String>(
                      value: selectedCategoryId,
                      decoration: const InputDecoration(
                        labelText: 'Select Category',
                        border: OutlineInputBorder(),
                      ),
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category.id,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedCategoryId = value;
                      },
                    )
                  : const CircularProgressIndicator(),
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
                            categoryId: selectedCategoryId);
                        ref.read(itemProvider.notifier).addItem(newItem);
                        Navigator.of(context).pop();
                        context.goNamed(CatalogueScreen.name);
                      } else {
                        // TODO: mostrar un mensaje de error si el nombre está vacío o no se seleccionó una categoría
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
