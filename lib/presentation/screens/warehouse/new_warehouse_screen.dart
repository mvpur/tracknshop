import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_screen.dart';

class NewWarehouseScreen extends ConsumerStatefulWidget {
  const NewWarehouseScreen({super.key});
  static const String name = 'new_warehouse_screen';

  @override
  _NewWarehouseScreenState createState() => _NewWarehouseScreenState();
}

class _NewWarehouseScreenState extends ConsumerState<NewWarehouseScreen> {
  final TextEditingController _nameController = TextEditingController();
  IconData? selectedIcon;

  @override
  void dispose() {
    _nameController
        .dispose(); // Limpiar el controlador cuando se destruya la pantalla
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Warehouse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de texto para el nombre del nuevo almacén
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name of new warehouse',
                hintText: 'My Pantry',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.store),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => context.goNamed(WarehouseScreen.name),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please enter a name for the warehouse'),
                        ),
                      );
                      return;
                    }

                    final newWarehouse = Warehouse(
                      id: '',
                      name: _nameController.text.trim(),
                      date: DateTime.now(),
                      icon: '',
                    );

                    await ref
                        .read(warehouseProvider.notifier)
                        .addWarehouse(newWarehouse);

                    context.goNamed(WarehouseScreen.name);
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
