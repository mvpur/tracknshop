import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/screens/collection/collection_detail_screen.dart';
import 'package:track_shop_app/core/data/collection_datasource.dart';
import 'package:track_shop_app/entities/collection.dart';
import 'package:track_shop_app/presentation/screens/collection/new_collection_screen.dart';
import 'package:track_shop_app/presentation/widgets/items/collection_item.dart';

class CollectionScreen extends StatelessWidget {
  static const String name = 'collection_screen';
  final List<Collection> collections = collectionList;

  CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collection'),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: Colors.blue,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.collections),
            label: 'New Collection',
            onTap: () => context.goNamed(NewCollectionScreen.name),
          ),
          SpeedDialChild(
            child: const Icon(Icons.category),
            label: 'Add Category',
          ),
          SpeedDialChild(
            child: const Icon(Icons.inventory),
            label: 'Add Item',
          ),
        ],
      ),
      body: const _CollectionsView(),
    );
  }
}

class _CollectionsView extends StatelessWidget {
  const _CollectionsView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: collectionList.length,
      itemBuilder: (context, index) {
        final collection = collectionList[index];
        return CollectionItem(
          collection: collection,
          onTap: () => _goToCollectionDetails(context, collection),
        );
      },
    );
  }

  _goToCollectionDetails(BuildContext context, Collection collection) {
    context.pushNamed(
      CollectionDetailScreen.name,
      pathParameters: {
        'collectionId': collection.id,
      },
    );
  }
}
