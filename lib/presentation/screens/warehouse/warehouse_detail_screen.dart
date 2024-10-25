import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/screens/element/new_element_dialog.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';

class WarehouseDetailScreen extends ConsumerWidget {
  static const String name = 'warehouse_detail_screen';

  final String warehouseId;

  const WarehouseDetailScreen({super.key, required this.warehouseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Usamos ref.watch para escuchar cambios en la lista de almacenes
    final warehouses = ref.watch(warehouseProvider);

    // Buscamos el warehouse que coincide con el ID
    final warehouse = warehouses.firstWhere(
      (warehouse) => warehouse.id == warehouseId,
      orElse: () => Warehouse(
          id: warehouseId,
          name: '',
          icon: '',
          date: DateTime.now()), // Cambia a un objeto por defecto
    );

    if (warehouse.name.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Warehouse Detail')),
        body: const Center(child: Text('Warehouse not found')),
      );
    }

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
  final Warehouse warehouse;

  const _WarehouseDetailView({
    required this.warehouse,
  });

  @override
  Widget build(BuildContext context) {
    // Creamos los controladores para los TextFields
    final TextEditingController nameController =
        TextEditingController(text: warehouse.name);
    final TextEditingController iconController =
        TextEditingController(text: warehouse.icon);
    final TextEditingController dateController =
        TextEditingController(text: warehouse.date.toString());

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Warehouse Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: iconController,
              decoration: const InputDecoration(
                hintText: 'Icon',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: dateController,
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
