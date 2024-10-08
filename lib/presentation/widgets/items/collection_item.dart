import 'package:flutter/material.dart';
import 'package:track_shop_app/entities/collection.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem({
    super.key,
    required this.collection,
    this.onTap,
  });

  final Collection collection;

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(collection.name),
        onTap: () => onTap?.call(),
      ),
    );
  }
}
