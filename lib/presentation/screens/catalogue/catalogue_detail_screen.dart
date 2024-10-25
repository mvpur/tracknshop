import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/presentation/screens/element/new_element_dialog.dart';
import 'package:track_shop_app/presentation/provider/catalogue_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/screens/category/new_category_screen.dart';

class CatalogueDetailScreen extends ConsumerWidget {
  static const String name = 'catalogue_detail_screen';

  final String catalogueId;

  const CatalogueDetailScreen({super.key, required this.catalogueId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Usamos ref.watch para escuchar cambios en la lista de catálogos
    final catalogues = ref.watch(catalogueProvider);

    // Buscamos el catálogo que coincide con el ID
    final catalogue = catalogues.firstWhere(
      (catalogue) => catalogue.id == catalogueId,
      orElse: () => Catalogue(
        id: catalogueId,
        name: '',
        icon: '',
        date: DateTime.now(), // Cambia a un objeto por defecto
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
        title: const Text('Catalogue Detail'),
      ),
      floatingActionButton: _buildSpeedDial(context),
      body: _CatalogueDetailView(catalogue: catalogue),
    );
  }

  Widget _buildSpeedDial(BuildContext context) {
    return SpeedDial(
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
          child: const Icon(Icons.list_alt),
          label: 'New Element',
          onTap: () {
            showCreateElementDialog(context);
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.category),
          label: 'Add Category',
          onTap: () {
            context.goNamed(NewCategoryScreen.name);
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
    // Creamos los controladores para los TextFields
    final TextEditingController nameController =
        TextEditingController(text: catalogue.name);
    final TextEditingController iconController =
        TextEditingController(text: catalogue.icon);
    final TextEditingController dateController =
        TextEditingController(text: catalogue.date.toString());

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Catalogue Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: iconController,
              decoration: const InputDecoration(
                hintText: 'Icon',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: dateController,
              decoration: const InputDecoration(
                hintText: 'Date',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
