import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_screen.dart';

class NewElementScreen extends StatefulWidget {
  const NewElementScreen({super.key});
  static const String name = 'new_element_screen';

  @override
  // ignore: library_private_types_in_public_api
  _NewElementScreenState createState() => _NewElementScreenState();
}

class _NewElementScreenState extends State<NewElementScreen> {
  IconData? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Element'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name of new Element',
                hintText: 'Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.store),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //debería en ambos casos volver de la pagina que vino
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
  runApp(const MaterialApp(home: NewElementScreen()));
}
