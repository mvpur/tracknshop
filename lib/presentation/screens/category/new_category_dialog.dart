import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_screen.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewCategoryDialog extends ConsumerWidget {
  const NewCategoryDialog(this.warehouseId, this.catalogueId, {super.key});
  static const String name = 'new_category';
  final String? warehouseId;
  final String? catalogueId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();

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
                'New Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name of new category',
                  hintText: 'Supermarket',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.store),
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
                      final String categoryName = nameController.text.trim();
                      if (categoryName.isNotEmpty) {
                        final newCategory = Category(
                          id: '',
                          name: categoryName,
                          catalogueId: catalogueId,
                          warehouseId: warehouseId,
                        );
                        ref
                            .read(categoryProvider.notifier)
                            .addCategory(newCategory);
                        Navigator.of(context).pop();
                        context.goNamed(CatalogueScreen.name);
                      } else {
                        // TODO: mostrar un mensaje de error si el nombre está vacío
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
