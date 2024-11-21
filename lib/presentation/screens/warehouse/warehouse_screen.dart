import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/core/data/colors_datasourse.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/screens/warehouse/new_warehouse_screen.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_detail_screen.dart';
import 'package:track_shop_app/presentation/widgets/cards/warehouse_card.dart';
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
  Widget build(BuildContext context) {
    List<Warehouse> warehouses = ref.watch(warehouseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Warehouse'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'warehouseScreen',
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

  Color getColor(int index, BuildContext context) {
    final List<Color> colors = colorsList;
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    if (warehouses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warehouse_outlined,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              "No warehouses found",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "It seems you haven't added any warehouses yet.\nTap the '+' button to create one.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: warehouses.length,
      itemBuilder: (context, index) {
        final warehouse = warehouses[index];
        final itemColor = getColor(index, context);
        return WarehouseCard(
          warehouse: warehouse,
          onTap: () => _goToWarehouseDetails(context, warehouse),
          backgroundColor: itemColor,
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
