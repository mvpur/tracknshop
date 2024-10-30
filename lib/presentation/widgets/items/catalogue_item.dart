import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/presentation/provider/catalogue_provider.dart';

class CatalogueItem extends ConsumerWidget {
  const CatalogueItem({
    super.key,
    required this.catalogue,
    this.onTap,
    required this.backgroundColor,
  });

  final Catalogue catalogue;
  final Function? onTap;
  final Color backgroundColor;

  IconData getIcon(int iconCode) {
    return IconData(iconCode, fontFamily: 'MaterialIcons');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String formattedDate =
        DateFormat('dd/MM/yyyy').format(catalogue.date);

    return Card(
      color: backgroundColor,
      child: ListTile(
        leading: Icon(getIcon(catalogue.icon)),
        title: Text(catalogue.name.toString()),
        subtitle: Text('Date: $formattedDate'),
        onTap: () => onTap?.call(),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete'),
                  content: const Text(
                      'Are you sure you want to delete this catalogue?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () {
                        ref
                            .read(catalogueProvider.notifier)
                            .deleteCatalogue(catalogue.id);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
