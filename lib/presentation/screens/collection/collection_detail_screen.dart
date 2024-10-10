import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/core/data/collection_datasource.dart';
import 'package:track_shop_app/entities/collection.dart';
import 'package:track_shop_app/presentation/screens/category/new_category_screen.dart';
import 'package:track_shop_app/presentation/screens/element/new_element_screen.dart';

class CollectionDetailScreen extends StatelessWidget {
  static const String name = 'collection_detail_screen'; // Nombre de la ruta
  final String collectionId; // Parámetero de ID del ítem
  final isDialOpen = ValueNotifier(false);

  CollectionDetailScreen({super.key, required this.collectionId});

  @override
  // ignore: deprecated_member_use
  Widget build(BuildContext context) {
    // Obtén la colección basada en el ID
    final collection = collectionList
        .firstWhere((collection) => collection.id == collectionId);

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
          title: const Text('Collection'),
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
              onTap: () => context.goNamed(NewElementScreen.name),
            ),
          ],
        ),
        body: _CollectionDetailView(
            collection: collection), // Pasamos la colección
      ),
    );
  }
}

class _CollectionDetailView extends StatelessWidget {
  const _CollectionDetailView({
    required this.collection,
  });

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Name: ${collection.name}',
          ),
        ],
      ),
    );
  }
}
