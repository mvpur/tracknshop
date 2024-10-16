import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_screen.dart';

class NewCatalogueScreen extends StatefulWidget {
  const NewCatalogueScreen({super.key});
  static const String name = 'new_catalogue_screen';

  @override
  // ignore: library_private_types_in_public_api
  _NewCatalogueScreenState createState() => _NewCatalogueScreenState();
}

class _NewCatalogueScreenState extends State<NewCatalogueScreen> {
  IconData? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Catalogue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'New Catalogue',
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
                    onPressed: () => context.goNamed(CatalogueScreen.name),
                    child: const Text('Cancel')),
                FilledButton(
                    onPressed: () => context.goNamed(CatalogueScreen.name),
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
  runApp(const MaterialApp(home: NewCatalogueScreen()));
}
