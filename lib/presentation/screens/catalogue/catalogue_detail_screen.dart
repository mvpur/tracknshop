import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/core/data/catalogue_datasource.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/presentation/screens/category/new_category_screen.dart';
import 'package:track_shop_app/presentation/widgets/dialogs/element/new_element_dialog.dart';

class CatalogueDetailScreen extends StatelessWidget {
  static const String name = 'catalogue_detail_screen'; // Nombre de la ruta
  final String catalogueId; // Parámetero de ID del ítem
  final isDialOpen = ValueNotifier(false);

  CatalogueDetailScreen({super.key, required this.catalogueId});

  @override
  Widget build(BuildContext context) {
    final catalogue =
        catalogueList.firstWhere((catalogue) => catalogue.id == catalogueId);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Catalogue'),
        ),
        floatingActionButton: SpeedDial(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          icon: Icons.add,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          openCloseDial: isDialOpen,
          spacing: 12,
          spaceBetweenChildren: 12,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.category),
              label: 'Add Category',
              onTap: () => context.goNamed(NewCategoryScreen.name),
            ),
            SpeedDialChild(
              child: const Icon(Icons.dashboard_customize),
              label: 'Add Item',
              onTap: () {
                showCreateElementDialog(context);
              },
            ),
          ],
        ),
        body:
            _CatalogueDetailView(catalogue: catalogue), // Pasamos la colección
      ),
    );
  }
}

class _CatalogueDetailView extends StatelessWidget {
  const _CatalogueDetailView({
    required this.catalogue,
  });

  final Catalogue catalogue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Name: ${catalogue.name}',
          ),
        ],
      ),
    );
  }
}
