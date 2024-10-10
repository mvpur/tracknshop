import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_screen.dart';

class NewCollectionScreen extends StatefulWidget {
  const NewCollectionScreen({super.key});
  static const String name = 'new_collection_screen';

  @override
  // ignore: library_private_types_in_public_api
  _NewCollectionScreenState createState() => _NewCollectionScreenState();
}

class _NewCollectionScreenState extends State<NewCollectionScreen> {
  IconData? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Collection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'New Collection',
                hintText: 'Name',
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
                    child: const Text('Cancel')),
                FilledButton(
                    onPressed: () => context.goNamed(WarehouseScreen.name),
                    child: const Text('Confirm')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: NewCollectionScreen()));
}
