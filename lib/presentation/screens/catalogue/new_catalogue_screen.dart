import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/presentation/provider/catalogue_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_screen.dart';
import 'package:track_shop_app/core/data/icons_datasource.dart';

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              maxLength: 30,
              decoration: const InputDecoration(
                labelText: 'Name of new catalogue',
                hintText: 'Shopping List',
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
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
                  onPressed: () => context.goNamed(CatalogueScreen.name),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () async {
                    final catalogueName = _nameController.text.trim();
                    if (catalogueName.isEmpty || selectedIcon == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please enter a name and select an icon'),
                        ),
                      );
                      return;
                    }

                    if (catalogueName.length > 30) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Name can\'t exceed 30 characters'),
                        ),
                      );
                      return;
                    }

                    final newCatalogue = Catalogue(
                      name: catalogueName,
                      date: DateTime.now(),
                      icon: selectedIcon!.codePoint,
                      id: '',
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
