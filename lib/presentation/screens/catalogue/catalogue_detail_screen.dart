import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:track_shop_app/presentation/provider/catalogue_provider.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.notification_add_rounded),
            onPressed: () {
              // Acción al presionar el ícono de alarma
            },
          ),
        ],
      ),
      floatingActionButton: AppSpeedDial(
          heroTag: 'catalogueDetailSpeedDial', catalogue: catalogue),
      body: _CatalogueDetailView(categories: filteredCategories),
    );
  }
}

class _CatalogueDetailView extends ConsumerWidget {
  final List<Category> categories;

  const _CatalogueDetailView({required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemProvider);
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        const SizedBox(height: 16),
        if (categories.isNotEmpty)
          ...categories.map((category) {
            final filteredItems =
                items.where((item) => item.categoryId == category.id).toList();

            return ExpansionTile(
              title: Text(category.name),
              children: [
                if (filteredItems.isEmpty)
                  const ListTile(title: Text('No items available'))
                else
                  ...filteredItems.map((item) => ListTile(
                        title: Text(item.name),
                      )),
              ],
            );
          })
        else
          const Center(child: Text('No categories available')),
      ],
    );
  }
}
