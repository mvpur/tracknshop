import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_screen.dart';
import 'package:track_shop_app/core/data/icons_datasource.dart';

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
    _nameController.dispose();
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              maxLength: 30, 
              decoration: const InputDecoration(
                labelText: 'Name of new warehouse',
                hintText: 'My Fridge',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.store),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Select an icon:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: iconList.length,
                itemBuilder: (context, index) {
                  final icon = iconList[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIcon = icon;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedIcon == icon
                            ? Colors.blueAccent.withOpacity(0.2)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: selectedIcon == icon ? Colors.blue : Colors.grey,
                      ),
                    ),
                  );
                },
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
                    final warehouseName = _nameController.text.trim();
                    if (warehouseName.isEmpty || selectedIcon == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please enter a name and select an icon'),
                        ),
                      );
                      return;
                    }

                    if (warehouseName.length > 30) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Name can\'t exceed 30 characters'),
                        ),
                      );
                      return;
                    }

                    final newWarehouse = Warehouse(
                      name: warehouseName,
                      date: DateTime.now(),
                      icon: selectedIcon!.codePoint,
                      id: '',
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
