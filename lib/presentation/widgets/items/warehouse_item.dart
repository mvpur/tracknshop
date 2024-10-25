import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';

class WarehouseItem extends ConsumerWidget {
  const WarehouseItem({
    super.key,
    required this.warehouse,
    this.onTap,
  });

  final Warehouse warehouse;
  final Function? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String formattedDate =
        DateFormat('dd/MM/yyyy').format(warehouse.date);

    return Card(
      child: ListTile(
        title: Text(warehouse.name.toString()),
        subtitle: Text('Date: $formattedDate'),
        onTap: () => onTap?.call(),
        trailing: IconButton(
          icon: const Icon(Icons.delete), // Ícono de eliminar
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete'),
                  content: const Text(
                      'Are you sure you want to delete this warehouse?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () {
                        ref
                            .read(warehouseProvider.notifier)
                            .deleteWarehouse(warehouse.id);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
