import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';

class WarehouseCard extends ConsumerWidget {
  const WarehouseCard({
    super.key,
    required this.warehouse,
    this.onTap,
    required this.backgroundColor,
  });

  final Warehouse warehouse;
  final Function? onTap;
  final Color backgroundColor;

  IconData getIcon(int iconCode) {
    return IconData(iconCode, fontFamily: 'MaterialIcons');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String formattedDate =
        DateFormat('dd/MM/yyyy').format(warehouse.date);

    return Card(
      color: backgroundColor,
      child: ListTile(
        leading: Icon(getIcon(warehouse.icon)),
        title: Text(warehouse.name.toString()),
        subtitle: Text(formattedDate),
        onTap: () => onTap?.call(),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
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
