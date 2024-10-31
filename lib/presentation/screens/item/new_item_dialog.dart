import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_screen.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewItemDialog extends ConsumerWidget {
  const NewItemDialog({super.key});
  static const String name = 'new_item';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();

    return AlertDialog(
      title: const Text('New Item'),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name of new item',
                hintText: 'Milk',
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
            final String itemName = nameController.text.trim();
            if (itemName.isNotEmpty) {
              final newItem = Item(
                  id: '',
                  name: itemName,
                  catalogueId: '',
                  warehouseId: '',
                  categoryId: '');
              ref.read(itemProvider.notifier).addItem(newItem);
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
