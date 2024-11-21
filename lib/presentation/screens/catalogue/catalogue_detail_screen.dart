import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/presentation/provider/catalogue_provider.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_detail_view.dart';
import 'package:track_shop_app/presentation/widgets/navbar_and_speeddial/speed_dial.dart';

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
      body: CategoryDetailView(categories: filteredCategories),
    );
  }
}
