import 'package:flutter/material.dart';
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
