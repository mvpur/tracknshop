/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';
import 'package:track_shop_app/presentation/screens/warehouse/new_warehouse_screen.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_detail_screen.dart';
import 'package:track_shop_app/presentation/widgets/items/warehouse_item.dart';

class WarehouseScreen extends StatefulWidget {
  static const String name = 'warehouse_screen';

  WarehouseScreen({super.key});

  @override
  _WarehouseScreenState createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  List<Warehouse> warehouses = [];

  @override
  void initState() {
    super.initState();
    fetchWarehouses();
  }

  Future<void> fetchWarehouses() async {
    List<Warehouse> warehouseData = await getAllWarehouses();
    setState(() {
      warehouses =
          warehouseData; // Asegúrate de que warehouses sea de tipo List<Warehouse>
    });
  }

  @override
  Widget build(BuildContext context) {
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

  _goToWarehouseDetails(BuildContext context, Warehouse warehouse) {
    context.pushNamed(
      WarehouseDetailScreen.name,
      pathParameters: {
        'warehouseId': warehouse.id,
      },
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/screens/warehouse/new_warehouse_screen.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_detail_screen.dart';
import 'package:track_shop_app/presentation/widgets/items/warehouse_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';

class WarehouseScreen extends ConsumerStatefulWidget {
  static const String name = 'warehouse_screen';

  WarehouseScreen({super.key});

  @override
  ConsumerState<WarehouseScreen> createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends ConsumerState<WarehouseScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(warehouseProvider.notifier).getAllWarehouses();
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
        print(warehouse.id);
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
