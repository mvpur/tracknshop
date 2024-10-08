import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/core/data/warehouse_datasource.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_detail_screen.dart';
import 'package:track_shop_app/presentation/widgets/items/warehouse_item.dart';

class WarehouseScreen extends StatelessWidget {
  static const String name = 'warehouse_screen';
  final List<Warehouse> warehouses = warehouseList;

  WarehouseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warehouse'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/new-warehouse'),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      body: const _WarehousesView(),
    );
  }
}

class _WarehousesView extends StatelessWidget {
  const _WarehousesView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: warehouseList.length,
      itemBuilder: (context, index) {
        final warehouse = warehouseList[index];
        return WarehouseItem(
          warehouse: warehouse,
          onTap: () => _goToWarehouseDetails(context, warehouse),
        );
      },
    );
  }

  _goToWarehouseDetails(BuildContext context, Warehouse warehouse) {
    context.pushNamed(
      WarehouseDetailScreen.name,
      pathParameters: {
        'warehouseId': warehouse.id,
      },
    );
  }
}
