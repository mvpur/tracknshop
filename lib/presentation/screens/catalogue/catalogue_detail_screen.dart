import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/presentation/provider/catalogue_provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            catalogue.getIcon(), // Mostrar el ícono del catálogo
            const SizedBox(width: 8),
            Text(catalogue.name),
          ],
        ),
      ),
      floatingActionButton: _buildSpeedDial(context),
      body: _CatalogueDetailView(catalogue: catalogue),
    );
  }

  Widget _buildSpeedDial(BuildContext context) {
    return SpeedDial(
      heroTag: 'catalogueDetailSpeedDial',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      icon: Icons.add,
      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      spacing: 12,
      spaceBetweenChildren: 12,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.add),
          label: 'Add Item',
          onTap: () {
            // TODO: Lógica para añadir un nuevo ítem
          },
        ),
      ],
    );
  }
}

class _CatalogueDetailView extends StatelessWidget {
  final Catalogue catalogue;

  const _CatalogueDetailView({
    required this.catalogue,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        const SizedBox(height: 16),
        if (catalogue.categories != null)
          ...catalogue.categories!.map((category) {
            return ExpansionTile(
              title: Text(category.name),
              children: category.items != null
                  ? category.items!.map((item) {
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text('Category: ${category.name}'),
                      );
                    }).toList()
                  : [const Text('No items available')],
            );
          }).toList()
        else
          const Center(child: CircularProgressIndicator()), // Loading indicator
      ],
    );
  }
}
