import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';

class CategoryListView extends ConsumerWidget {
  final List<Category> categories;

  const CategoryListView({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemProvider);

    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        const SizedBox(height: 16),
        if (categories.isNotEmpty)
          ...categories.map((category) {
            final filteredItems =
                items.where((item) => item.categoryId == category.id).toList();

            return ExpansionTile(
              title: Text(category.name),
              children: [
                if (filteredItems.isEmpty)
                  const ListTile(title: Text('No items available'))
                else
                  ...filteredItems.map((item) => ListTile(
                        title: Text(item.name),
                      )),
              ],
            );
          })
        else
          const Center(child: Text('No categories available')),
      ],
    );
  }
}
