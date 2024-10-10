import 'package:flutter/material.dart';
import 'package:track_shop_app/core/data/warehouse_datasource.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/widgets/dialogs/element/new_element_dialog.dart';

class WarehouseDetailScreen extends StatelessWidget {
  static const String name = 'warehouse_detail_screen';
  final String warehouseId;

  const WarehouseDetailScreen({super.key, required this.warehouseId});

  @override
  Widget build(BuildContext context) {
    final warehouse =
        warehouseList.firstWhere((warehouse) => warehouse.id == warehouseId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Warehouse Detail'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateElementDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: _WarehouseDetailView(warehouse: warehouse),
    );
  }
}

class _WarehouseDetailView extends StatelessWidget {
  const _WarehouseDetailView({
    required this.warehouse,
  });

  final Warehouse warehouse;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Name: ${warehouse.name}',
          )
        ],
      ),
    );
  }
}
