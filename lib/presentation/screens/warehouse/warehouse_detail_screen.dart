import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
      body: _WarehouseDetailView(warehouse: warehouse),
    );
  }

  Widget _buildSpeedDial(BuildContext context) {
    return SpeedDial(
      heroTag: 'warehouseDetail',
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
      ],
    );
  }
}

class _WarehouseDetailView extends StatelessWidget {
  final Warehouse warehouse;

  const _WarehouseDetailView({
    required this.warehouse,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: warehouse.items?.length ?? 0,
      itemBuilder: (context, index) {
        final item = warehouse.items![index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(item.categoryId),
        );
      },
    );
  }
}
