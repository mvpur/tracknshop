import 'package:flutter/material.dart';

class NewWarehouseScreen extends StatefulWidget {
  const NewWarehouseScreen({super.key});
  static const String name = 'new_warehouse_screen';

  @override
  // ignore: library_private_types_in_public_api
  _NewWarehouseScreenState createState() => _NewWarehouseScreenState();
}

class _NewWarehouseScreenState extends State<NewWarehouseScreen> {
  IconData? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Warehouse'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name of new Warehouse',
                hintText: 'Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.store),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: NewWarehouseScreen()));
}
