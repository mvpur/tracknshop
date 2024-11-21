import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';
import 'package:track_shop_app/presentation/screens/reminder/new_reminder_dialog.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_detail_view.dart';
import 'package:track_shop_app/presentation/widgets/navbar_and_speeddial/speed_dial.dart';

class WarehouseDetailScreen extends ConsumerWidget {
  static const String name = 'warehouse_detail_screen';

  final String warehouseId;

  const WarehouseDetailScreen({super.key, required this.warehouseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final warehouses = ref.watch(warehouseProvider);

    final warehouse = warehouses.firstWhere(
      (warehouse) => warehouse.id == warehouseId,
      orElse: () => Warehouse(
        id: warehouseId,
        name: '',
        icon: 0,
        date: DateTime.now(),
      ),
    );

    if (warehouse.name.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Warehouse Detail')),
        body: const Center(child: Text('Warehouse not found')),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (warehouse.date != DateTime.now()) {
        ref.read(warehouseProvider.notifier).updateWarehouseDate(warehouse.id);
      }
    });

    final categories = ref.watch(categoryProvider);

    final filteredCategories = categories
        .where((category) => category.warehouseId == warehouseId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            warehouse.getIcon(),
            const SizedBox(width: 8),
            Text(warehouse.name),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notification_add_rounded),
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return NewReminderDialog(
                    title: warehouse.name,
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: AppSpeedDial(
          heroTag: 'warehouseDetailSpeedDial', warehouse: warehouse),
      body: WarehouseDetailView(categories: filteredCategories),
    );
  }
}
