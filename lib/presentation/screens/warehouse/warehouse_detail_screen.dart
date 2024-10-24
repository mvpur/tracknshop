/*import 'package:flutter/material.dart';
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
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/core/data/warehouse_datasource.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/widgets/dialogs/element/new_element_dialog.dart';

class WarehouseDetailScreen extends ConsumerWidget {
  static const String name = 'warehouse_detail_screen';

  final String warehouseId;

  const WarehouseDetailScreen({super.key, required this.warehouseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Aquí puedes usar Riverpod para obtener el warehouse desde un provider
    // Suponiendo que usas Riverpod, podrías acceder a un provider similar a esto:
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
    final TextEditingController nameController = TextEditingController();
    final TextEditingController iconController = TextEditingController();
    final TextEditingController dateController = TextEditingController();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController..text = warehouse.name,
              decoration: const InputDecoration(
                hintText: 'Warehouse Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: iconController..text = warehouse.icon,
              decoration: const InputDecoration(
                hintText: 'Icon',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: dateController..text = warehouse.date.toString(),
              decoration: const InputDecoration(
                hintText: 'Date',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
