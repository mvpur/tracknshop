import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';

class AssignCatalogueDialog extends StatelessWidget {
  final List<Catalogue> catalogues;
  final String categoryId;
  final WidgetRef ref;

  const AssignCatalogueDialog({
    super.key,
    required this.catalogues,
    required this.categoryId,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Assign Catalogue to Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: catalogues.map((catalogue) {
          return ListTile(
            leading: catalogue.getIcon(),
            title: Text(catalogue.name),
            onTap: () {
              ref.read(categoryProvider.notifier).assignCatalogue(
                    categoryId: categoryId,
                    catalogueId: catalogue.id,
                  );
              Navigator.of(context).pop();
            },
          );
        }).toList(),
      ),
    );
  }
}
