import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';

class AssignWarehouseDialog extends StatelessWidget {
  final List<Warehouse> warehouses;
  final String categoryId;
  final WidgetRef ref;

  const AssignWarehouseDialog({
    super.key,
    required this.warehouses,
    required this.categoryId,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Assign Warehouse to Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: warehouses.map((warehouse) {
          return ListTile(
            leading: warehouse.getIcon(),
            title: Text(warehouse.name),
            onTap: () {
              ref.read(categoryProvider.notifier).assignWarehouse(
                    categoryId: categoryId,
                    warehouseId: warehouse.id,
                  );
              Navigator.of(context).pop();
            },
          );
        }).toList(),
      ),
    );
  }
}
