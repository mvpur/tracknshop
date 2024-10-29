import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';

class ItemList extends ConsumerWidget {
  final String warehouseId;

  const ItemList({super.key, required this.warehouseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemProvider);

    // Filtrar items por warehouseId si es necesario
    final warehouseItems =
        items.where((item) => item.warehouseId == warehouseId).toList();

    return ListView.builder(
      itemCount: warehouseItems.length,
      itemBuilder: (context, index) {
        final item = warehouseItems[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(
              'ID: ${item.id}'), // Asegúrate de que `id` esté en tu clase Item
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Aquí puedes llamar a un método para eliminar el item
              ref.read(itemProvider.notifier).deleteItem(item.id);
            },
          ),
        );
      },
    );
  }
}
