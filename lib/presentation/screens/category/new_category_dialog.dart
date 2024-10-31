import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_screen.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewCategoryDialog extends ConsumerWidget {
  const NewCategoryDialog({super.key});
  static const String name = 'new_category';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();

    return AlertDialog(
      title: const Text('New Category'),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final String categoryName = nameController.text.trim();
            if (categoryName.isNotEmpty) {
              final newCategory = Category(
                  id: '', name: categoryName, catalogueId: '', warehouseId: '');
              ref.read(categoryProvider.notifier).addCategory(newCategory);
              Navigator.of(context).pop(); 
              context.goNamed(CatalogueScreen.name);
            } else {
              // TODO: mostrar un mensaje de error si el nombre está vacío
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
