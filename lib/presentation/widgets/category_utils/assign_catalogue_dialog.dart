import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';

class AssignCatalogueDialog extends StatelessWidget {
  final List<Category> categoriesProvider;
  final String categoryId;
  final WidgetRef ref;

  const AssignCatalogueDialog({
    super.key,
    required this.categoriesProvider,
    required this.categoryId,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Assign Catalogue to Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: categoriesProvider.map((category) {
          return ListTile(
            title: Text(category.name),
            onTap: () {
              ref.read(categoryProvider.notifier).assignCatalogue(
                    categoryId: categoryId,
                    catalogueId: category.id,
                  );
              Navigator.of(context).pop();
            },
          );
        }).toList(),
      ),
    );
  }
}
