import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/screens/warehouse/new_warehouse_screen.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_detail_screen.dart';
import 'package:track_shop_app/presentation/widgets/items/warehouse_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';

class WarehouseScreen extends ConsumerStatefulWidget {
  static const String name = 'warehouse_screen';

  const WarehouseScreen({super.key});

  @override
  ConsumerState<WarehouseScreen> createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends ConsumerState<WarehouseScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Warehouse> warehouses = ref.watch(warehouseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Warehouse'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(NewWarehouseScreen.name),
        child: const Icon(Icons.add),
      ),
      body: _WarehousesView(warehouses: warehouses),
    );
  }
}

class _WarehousesView extends StatelessWidget {
  final List<Warehouse> warehouses;

  const _WarehousesView({required this.warehouses});

  @override
  Widget build(BuildContext context) {
    if (warehouses.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: warehouses.length,
      itemBuilder: (context, index) {
        final warehouse = warehouses[index];
        return WarehouseItem(
          warehouse: warehouse,
          onTap: () => _goToWarehouseDetails(context, warehouse),
        );
      },
    );
  }

  void _goToWarehouseDetails(BuildContext context, Warehouse warehouse) {
    context.pushNamed(
      WarehouseDetailScreen.name,
      pathParameters: {
        'warehouseId': warehouse.id,
      },
    );
  }
}
