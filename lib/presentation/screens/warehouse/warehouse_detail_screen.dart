import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';
import 'package:track_shop_app/presentation/widgets/speed_dial.dart';

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
            onPressed: () {
              // Acción al presionar el ícono de alarma
            },
          ),
        ],
      ),
      floatingActionButton: AppSpeedDial(
          heroTag: 'warehouseDetailSpeedDial', warehouse: warehouse),
      body: _WarehouseDetailView(categories: filteredCategories),
    );
  }
}

class _WarehouseDetailView extends ConsumerWidget {
  final List<Category> categories;

  const _WarehouseDetailView({required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemProvider);

    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        const SizedBox(height: 16),
        if (categories.isNotEmpty)
          ...categories.map((category) {
            final filteredItems =
                items.where((item) => item.categoryId == category.id).toList();

            return ExpansionTile(
              title: Text(category.name),
              children: [
                if (filteredItems.isEmpty)
                  const ListTile(title: Text('No items available'))
                else
                  ...filteredItems.map((item) => ListTile(
                        title: Text(item.name),
                      )),
              ],
            );
          })
        else
          const Center(child: Text('No categories available')),
      ],
    );
  }
}
