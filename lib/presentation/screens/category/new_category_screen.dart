import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_screen.dart';

//TODO: Convertir a Dialog

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({super.key});
  static const String name = 'new_category_screen';

  @override
  // ignore: library_private_types_in_public_api
  _NewCategoryScreenState createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  IconData? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name of new Category',
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
  runApp(const MaterialApp(home: NewCategoryScreen()));
}
