import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:track_shop_app/core/data/collection_datasource.dart';
import 'package:track_shop_app/entities/collection.dart';

class CollectionDetailScreen extends StatelessWidget {
  static const String name = 'collection_detail_screen'; // Nombre de la ruta
  final String collectionId; // Parámetero de ID del ítem

  const CollectionDetailScreen({super.key, required this.collectionId});

  @override
  Widget build(BuildContext context) {
    final collection = collectionList
        .firstWhere((collection) => collection.id == collectionId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collection Detail'),
      ),
      floatingActionButton: SpeedDial(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        icon: Icons.add,
        backgroundColor: Colors.blue,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.category),
            label: 'Add Category',
            onTap: () => (),
          ),
          SpeedDialChild(
            child: const Icon(Icons.dashboard_customize),
            label: 'Add Item',
            onTap: () => (),
          ),
        ],
      ),
      body: _CollectionDetailView(collection: collection),
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
          )
        ],
      ),
    );
  }
}
