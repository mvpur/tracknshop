import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:track_shop_app/entities/item.dart';
import 'package:track_shop_app/presentation/provider/catalogue_provider.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:track_shop_app/presentation/screens/category/new_category_dialog.dart';
import 'package:track_shop_app/presentation/screens/item/new_item_dialog.dart';
import 'package:track_shop_app/presentation/widgets/speed_dial.dart';

class CatalogueDetailScreen extends ConsumerWidget {
  static const String name = 'catalogue_detail_screen';

  final String catalogueId;

  const CatalogueDetailScreen({super.key, required this.catalogueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogues = ref.watch(catalogueProvider);

    final catalogue = catalogues.firstWhere(
      (catalogue) => catalogue.id == catalogueId,
      orElse: () => Catalogue(
        id: catalogueId,
        name: '',
        icon: 0,
        date: DateTime.now(),
      ),
    );

    if (catalogue.name.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Catalogue Detail')),
        body: const Center(child: Text('Catalogue not found')),
      );
    }

    final categories = ref.watch(categoryProvider);

    final filteredCategories = categories
        .where((category) => category.catalogueId == catalogueId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            catalogue.getIcon(),
            const SizedBox(width: 8),
            Text(catalogue.name),
          ],
        ),
      ),
      floatingActionButton: AppSpeedDial(
          heroTag: 'catalogueDetailSpeedDial', catalogue: catalogue),
      body: _CatalogueDetailView(categories: filteredCategories),
    );
  }
}

class _CatalogueDetailView extends StatelessWidget {
  final List<Category> categories;

  const _CatalogueDetailView({required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        const SizedBox(height: 16),
        if (categories.isNotEmpty)
          ...categories.map((category) {
            return ExpansionTile(
              title: Text(category.name),
              children: [
                FutureBuilder<List<Item>>(
                  future: category.loadItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading items'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const ListTile(title: Text('No items available'));
                    } else {
                      return Column(
                        children: snapshot.data!.map((item) {
                          return ListTile(
                            title: Text(item.name),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ],
            );
          }).toList()
        else
          const Center(child: Text('No categories available')),
      ],
    );
  }
}
