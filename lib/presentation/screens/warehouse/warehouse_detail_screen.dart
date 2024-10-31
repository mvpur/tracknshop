import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:track_shop_app/presentation/screens/category/new_category_dialog.dart';

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
      ),
      floatingActionButton: _buildSpeedDial(context),
      body: _WarehouseDetailView(categories: filteredCategories),
    );
  }

  Widget _buildSpeedDial(BuildContext context) {
    return SpeedDial(
      heroTag: 'warehouseDetailSpeedDial',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      icon: Icons.add,
      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      spacing: 12,
      spaceBetweenChildren: 12,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.add),
          label: 'Add Item',
          onTap: () {
            // TODO: Lógica para añadir un nuevo ítem
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.add),
          label: 'Add category',
          onTap: () => context.goNamed(NewCategoryDialog.name),
        ),
      ],
    );
  }
}

class _WarehouseDetailView extends ConsumerWidget {
  final List<Category> categories;

  const _WarehouseDetailView({required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        const SizedBox(height: 16),
        if (categories.isNotEmpty)
          ...categories.map((category) {
            return ExpansionTile(
              title: Text(category.name),
              children: [
                FutureBuilder<List<Item>>(
                  future: category
                      .loadItems(), // Asegúrate de que esto esté correcto
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading items'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const ListTile(title: Text('No items available'));
                    } else {
                      return Column(
                        children: snapshot.data!.map((item) {
                          return ListTile(
                            title: Text(item.name),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ],
            );
          }).toList()
        else
          const Center(child: Text('No categories available')),
      ],
    );
  }
}
