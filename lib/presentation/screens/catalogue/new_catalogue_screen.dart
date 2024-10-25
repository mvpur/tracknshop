import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/presentation/provider/catalogue_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_screen.dart';

class NewCatalogueScreen extends ConsumerStatefulWidget {
  const NewCatalogueScreen({super.key});
  static const String name = 'new_catalogue_screen';

  @override
  _NewCatalogueScreenState createState() => _NewCatalogueScreenState();
}

class _NewCatalogueScreenState extends ConsumerState<NewCatalogueScreen> {
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
        title: const Text('New Catalogue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name of new catalogue',
                hintText: 'Shopping List',
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
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please enter a name for the catalogue'),
                        ),
                      );
                      return;
                    }

                    final newCatalogue = Catalogue(
                      id: '',
                      name: _nameController.text.trim(),
                      date: DateTime.now(),
                      icon: '',
                    );

                    await ref
                        .read(catalogueProvider.notifier)
                        .addCatalogue(newCatalogue);

                    context.goNamed(CatalogueScreen.name);
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
